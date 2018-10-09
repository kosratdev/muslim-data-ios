//
//  main.swift
//  PrayerTimes
//
//  Created by Abdullah Alhazmy on 1/26/16.
//  Copyright © 2016 Abdullah Alhazmy. All rights reserved.
//

import Foundation

open class Prayer {
    // ---------------------- Global Variables --------------------
    open var caculationMethod: CalculationMethods = .makkah // CalculationMethods(rawValue:  4)! // caculation method
    open var asrJuristic: AsrJuristicMethods = .shafii // Juristic method for Asr
    var dhuhrMinutes: Int = 0 // minutes after mid-day for Dhuhr
    open var adjustHighLats: AdjustingMethods = .none // adjusting method for higher latitudes
    open var timeFormat: TimeForamts = .time24 // time format
    var prayerTimesCurrent: [Double] = []
    var offsets = [Double](repeating: 0.0, count: 7)
    var lat: Double = Double() // latitude
    var lng: Double = Double() // longitude
    var timeZone: Double = Double() // time-zone
    var JDate: Double = Double() // 0.0 // Julian date

    public enum PrayerName: String {
        case Fajr
        case Sunrise
        case Dhuhr
        case Asr
        case Sunset
        case Maghrib
        case Isha
        case InvalidTime = " ---- "
    }

    // ------------------------------------------------------------
    // Calculation Methods
    public enum CalculationMethods: Int {
        case jafari = 0 // Ithna Ashari
        case karachi // University of Islamic Sciences, Karachi
        case isna // Islamic Society of North America (ISNA)
        case mwl // Muslim World League (MWL)
        case makkah // Umm al-Qura, Makkah
        case egypt // Egyptian General Authority of Survey
        case custom // Custom Setting
        case tehran // Institute of Geophysics, University of Tehran
    }

    // ------------------------------------------------------------
    // Juristic Methods
    public enum AsrJuristicMethods: Int {
        case shafii // Shafii (standard)
        case hanafi // Hanafi
    }

    // ------------------------------------------------------------
    // Adjusting Methods for Higher Latitudes
    public enum AdjustingMethods: Int {
        case none // No adjustment
        case midNight // middle of night
        case oneSeventh // 1/7th of night
        case angleBased // floating point number
    }

    // ------------------------------------------------------------
    // Time Formats
    public enum TimeForamts: Int {
        case time24 // 24-hour format
        case time12 // 12-hour format
        case time12NS // 12-hour format with no suffix
        case floating // angle/60th of night
    }

    // ------------------------------------------------------------
    // Time Names
    let prayerTimeNames: [PrayerName] = [.Fajr, .Sunrise, .Dhuhr, .Asr, .Sunset, .Maghrib, .Isha]
    // ------------------------------------------------------------
    // Time Names
    let numIterations: Int = 1 // number of iterations needed to compute times
    var methodParams: [CalculationMethods: [Double]] = [
        .jafari: [16, 0, 4, 0, 14],
        .karachi: [18, 1, 0, 0, 18],
        .isna: [15, 1, 0, 0, 15],
        .mwl: [18, 1, 0, 0, 17],
        .makkah: [18.5, 1, 0, 1, 90],
        .egypt: [18, 1, 0, 0, 17],
        .custom: [19.5, 1, 0, 0, 17.5],
        .tehran: [17.7, 0, 4.5, 0, 14],
    ]

    // ------------------------------------------------------------
    // Init
    public init(caculationmethod: CalculationMethods, asrJuristic: AsrJuristicMethods, adjustHighLats: AdjustingMethods, timeFormat: TimeForamts) {
        caculationMethod = caculationmethod
        self.asrJuristic = asrJuristic
        self.adjustHighLats = adjustHighLats
        self.timeFormat = timeFormat
    }

    public init(caculationmethod _: CalculationMethods, asrJuristic _: AsrJuristicMethods, adjustHighLats _: AdjustingMethods, timeFormat _: TimeForamts, offsets: [Double]) {
        self.offsets = offsets
    }

    // ---------------------- Julian Date Functions -----------------------
    // calculate julian date from a calendar date
    func julianDate(_ year: Int, month: Int, day: Int) -> Double {
        var adujestedYear = year
        var adujestedMonth = month

        if adujestedMonth <= 2 {
            adujestedYear = adujestedYear - 1
            adujestedMonth = adujestedMonth + 12
        }

        let a = floor(Double(adujestedYear) / 100.0)
        let b = 2 - a + floor(a / 4.0)
        let jd1 = floor(365.25 * Double(adujestedYear + 4716))
        let jd2 = floor(30.6001 * Double(adujestedMonth + 1))
        let jd = jd1 + jd2 + Double(day) + b - 1524.5

        return jd
    }

    // convert a calendar date to julian date (second method)
    func calcJD(_ year: Int, month: Int, day: Int) -> Double {
        let J1970 = 2_440_588.0
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let calendar = Calendar.current.date(from: dateComponents)
        let ms = (calendar?.timeIntervalSince1970)! * 1000 // # of milliseconds since midnight Jan 1,
        // 1970
        let days = floor(ms / (1000.0 * 60.0 * 60.0 * 24.0))
        return J1970 + days - 0.5
    }

    // ---------------------- Calculation Functions -----------------------
    // References:
    // http://www.ummah.net/astronomy/saltime
    // http://aa.usno.navy.mil/faq/docs/SunApprox.html
    // compute declination angle of sun and equation of time
    func sunPosition(_ jd: Double) -> [Double] {
        let D = jd - 2_451_545
        let g = Double.fixAngle(357.529 + 0.98560028 * D)
        let q = Double.fixAngle(280.459 + 0.98564736 * D)
        let L = Double.fixAngle(q + (1.915 * Double.dSin(g)) + (0.020 * Double.dSin(2 * g)))

        // double R = 1.00014 - 0.01671 * [self dCos:g] - 0.00014 * [self dCos:
        // (2*g)]
        let e = 23.439 - (0.00000036 * D)
        let d = Double.dArcSin(Double.dSin(e) * Double.dSin(L))
        var RA = Double.dArcTan2((Double.dCos(e) * Double.dSin(L)), x: Double.dCos(L)) / 15.0
        RA = Double.fixHour(RA)
        let EqT = q / 15.0 - RA
        let sPosition: [Double] = [d, EqT]
        return sPosition
    }

    // compute equation of time
    func equationOfTime(_ jd: Double) -> Double {
        return sunPosition(jd)[1]
    }

    // compute declination angle of sun
    func sunDeclination(_ jd: Double) -> Double {
        return sunPosition(jd)[0]
    }

    // compute mid-day (Dhuhr, Zawal) time
    func computeMidDay(_ t: Double) -> Double {
        let T = equationOfTime(JDate + t)
        let Z = Double.fixHour(12 - T)
        return Z
    }

    // compute time for a given angle G
    func computeTime(_ G: Double, t: Double) -> Double {
        let D = sunDeclination(JDate + t)
        let Z = computeMidDay(t)
        let Beg = -Double.dSin(G) - Double.dSin(D) * Double.dSin(lat)
        let Mid = Double.dCos(D) * Double.dCos(lat)
        let V = Double.dArcCos(Beg / Mid) / 15.0
        return Z + (G > 90 ? -V : V)
    }

    // compute the time of Asr
    // Shafii: step=1, Hanafi: step=2
    func computeAsr(_ step: Double, t: Double) -> Double {
        let D = sunDeclination(JDate + t)
        let G = -Double.dArcCot(step + Double.dTan(abs(lat - D)))
        return computeTime(G, t: t)
    }

    // ---------------------- Misc Functions -----------------------
    // compute the difference between two times
    func timeDiff(_ time1: Double, time2: Double) -> Double {
        return Double.fixHour(time2 - time1)
    }

    // -------------------- Interface Functions --------------------
    // return prayer times for a given date
    func getDatePrayerTimes(_ year: Int, month: Int, day: Int, latitude: Double, longitude: Double, tZone: Double) -> [String: String] {
        lat = latitude
        lng = longitude
        timeZone = tZone
        JDate = julianDate(year, month: month, day: day)
        let lonDiff = longitude / (15.0 * 24.0)
        JDate = JDate - lonDiff
        return computeDayTimes()
    }

    // return prayer times for a given date
    open func getPrayerTimes(_ date: Date, latitude: Double, longitude: Double, tZone: Double) -> [String: String] {
        let year = Calendar.current.component(.year, from: date)
        let month = Calendar.current.component(.month, from: date)
        let day = Calendar.current.component(.day, from: date)

        return getDatePrayerTimes(year, month: month, day: day, latitude: latitude, longitude: longitude, tZone: tZone)
    }

    // set custom values for calculation parameters
    open func setCustomParams(_ params: [Double]) {
        var newCustomeParms: [Double] = []
        for i in 1 ... 5 {
            if params[i] == -1 {
                let parm = methodParams[caculationMethod]
                newCustomeParms.append(parm![i])
            } else {
                newCustomeParms.append(params[i])
            }
        }
        methodParams[.custom] = newCustomeParms
        caculationMethod = .custom
    }

    // set the angle for calculating Fajr
    func setFajrAngle(_ angle: Double) {
        let params = [angle, -1, -1, -1, -1]
        setCustomParams(params)
    }

    // set the angle for calculating Maghrib
    func setMaghribAngle(_ angle: Double) {
        let params = [-1, 0, angle, -1, -1]
        setCustomParams(params)
    }

    // set the angle for calculating Isha
    func setIshaAngle(_ angle: Double) {
        let params = [-1, -1, -1, 0, angle]
        setCustomParams(params)
    }

    // convert double hours to 24h format
    func floatToTime24(_ time: Double) -> String {
        var result: String

        if time.isNaN {
            return PrayerName.InvalidTime.rawValue
        }

        let fixedTime = Double.fixHour(time + 0.5 / 60.0) // add 0.5 minutes to round
        let hours = Int(floor(fixedTime))
        let minutes = Int(floor((Double(fixedTime) - Double(hours)) * 60.0))

        if (hours >= 0 && hours <= 9) && (minutes >= 0 && minutes <= 9) {
            result = "0\(hours):0\(minutes)"
        } else if hours >= 0 && hours <= 9 {
            result = "0\(hours):\(minutes)"
        } else if minutes >= 0 && minutes <= 9 {
            result = "\(hours):0\(minutes)"
        } else {
            result = "\(hours):\(minutes)"
        }
        return result
    }

    // convert double hours to 12h format
    func floatToTime12(_ time: Double, noSuffix: Bool) -> String {
        var adujestedTime = time

        if adujestedTime.isNaN {
            return PrayerName.InvalidTime.rawValue
        }

        adujestedTime = Double.fixHour(adujestedTime + 0.5 / 60) // add 0.5 minutes to round

        var hours: Int = Int(floor(adujestedTime))
        let minutes = Int(floor((Double(adujestedTime) - Double(hours)) * 60))
        var suffix: String, result: String
        if hours >= 12 {
            suffix = "pm"
        } else {
            suffix = "am"
        }
        hours = (((hours + 12) - 1) % 12) + 1
        /* hours = (hours + 12) - 1
         int hrs = (int) hours % 12
         hrs += 1 */
        if noSuffix == false {
            if (hours >= 0 && hours <= 9) && (minutes >= 0 && minutes <= 9) {
                result = "0\(hours):0\(minutes) \(suffix)"
            } else if hours >= 0 && hours <= 9 {
                result = "0\(hours):\(minutes) \(suffix)"
            } else if minutes >= 0 && minutes <= 9 {
                result = "\(hours):0\(minutes) \(suffix)"
            } else {
                result = "\(hours):\(minutes) \(suffix)"
            }

        } else {
            if (hours >= 0 && hours <= 9) && (minutes >= 0 && minutes <= 9) {
                result = "0\(hours):0\(minutes)"
            } else if hours >= 0 && hours <= 9 {
                result = "0\(hours):\(minutes)"
            } else if minutes >= 0 && minutes <= 9 {
                result = "\(hours):0\(minutes)"
            } else {
                result = "\(hours):\(minutes)"
            }
        }
        return result
    }

    // convert double hours to 12h format with no suffix
    func floatToTime12NS(_ time: Double) -> String {
        return floatToTime12(time, noSuffix: true)
    }

    // ---------------------- Compute Prayer Times -----------------------
    // compute prayer times at given julian date
    func computeTimes(_ times: [Double]) -> [Double] {
        let t = dayPortion(times)
        let parm: [Double] = methodParams[caculationMethod]!
        let Fajr = computeTime(180 - parm[0], t: t[0])

        let Sunrise = computeTime(180 - 0.833, t: t[1])

        let Dhuhr = computeMidDay(t[2])
        let Asr = computeAsr(1.0 + Double(asrJuristic.rawValue), t: t[3])
        let Sunset = computeTime(0.833, t: t[4])

        let Maghrib = computeTime(parm[2], t: t[5])
        let Isha = computeTime(parm[4], t: t[6])

        let CTimes: [Double] = [Fajr, Sunrise, Dhuhr, Asr, Sunset, Maghrib, Isha]

        return CTimes
    }

    // compute prayer times at given julian date
    func computeDayTimes() -> [String: String] {
        var times: [Double] = [5, 6, 12, 13, 18, 18, 18] // default times
        for _ in 1 ... numIterations {
            times = computeTimes(times)
        }
        times = adjustTimes(times)
        times = tuneTimes(times)
        return adjustTimesFormat(times)
    }

    // adjust times in a prayer time array
    func adjustTimes(_ times: [Double]) -> [Double] {
        var aTime: [Double] = []
        for i in 0 ..< times.count {
            let element = times[i] + timeZone - lng / 15
            aTime.append(element)
        }

        let parm = methodParams[caculationMethod]!

        aTime[2] = aTime[2] + Double(dhuhrMinutes) / 60 // Dhuhr
        if parm[1] == 1 { // Maghrib
            aTime[5] = aTime[4] + parm[2] / 60
        }
        if parm[3] == 1 { // Isha
            aTime[6] = aTime[5] + parm[4] / 60
        }

        if adjustHighLats != .none {
            aTime = adjustHighLatTimes(aTime)
        }

        return aTime
    }

    // convert times array to given time format
    func adjustTimesFormat(_ times: [Double]) -> [String: String] {
        var result = [String: String]()

        if timeFormat == .floating {
            for i in 0 ... 6 {
                result[prayerTimeNames[i].rawValue] = String(times[i])
            }
            return result
        }

        for i in 0 ... 6 {
            if timeFormat == .time12 {
                result[prayerTimeNames[i].rawValue] = floatToTime12(times[i], noSuffix: false)
            } else if timeFormat == .time12NS {
                result[prayerTimeNames[i].rawValue] = floatToTime12(times[i], noSuffix: true)
            } else {
                result[prayerTimeNames[i].rawValue] = floatToTime24(times[i])
            }
        }

        return result
    }

    func convertTimeToDictionarie(time: Set<String>) -> [String: String] {
        let array = Array(time)

        for time in array {
            print(time)
        }

        let result: [String: String] = [
            "Fajr": array[0],
            "Sunrise": array[1],
            "Dhuhr": array[2],
            "Asr": array[3],
            "Maghrib": array[4],
            "Isha": array[5],
        ]
        return result
    }

    // adjust Fajr, Isha and Maghrib for locations in higher latitudes
    func adjustHighLatTimes(_ timesParamter: [Double]) -> [Double] {
        var times = timesParamter
        let nightTime = timeDiff(times[4], time2: times[1]) // sunset to sunrise

        // Adjust Fajr
        let parm = methodParams[caculationMethod]!
        let FajrDiff = nightPortion(parm[0]) * nightTime

        if times[0].isNaN || timeDiff(times[0], time2: times[1]) > FajrDiff {
            times[0] = times[1] - FajrDiff
        }

        // Adjust Isha
        let IshaAngle = (parm[3] == 0) ? parm[4] : 18
        let IshaDiff = nightPortion(IshaAngle) * nightTime
        if times[6].isNaN || timeDiff(times[4], time2: times[6]) > IshaDiff {
            times[6] = times[4] + IshaDiff
        }

        // Adjust Maghrib
        let MaghribAngle = (parm[1] == 0) ? parm[2] : 4
        let MaghribDiff = nightPortion(MaghribAngle) * nightTime
        if times[5].isNaN || timeDiff(times[4], time2: times[5]) > MaghribDiff {
            times[5] = times[4] + MaghribDiff
        }

        return times
    }

    // the night portion used for adjusting times in higher latitudes
    func nightPortion(_ angle: Double) -> Double {
        var calc: Double = 0.0
        if adjustHighLats == .angleBased {
            calc = angle / 60.0
        } else if adjustHighLats == .midNight {
            calc = 0.5
        } else if adjustHighLats == .oneSeventh {
            calc = 0.14286
        }
        return calc
    }

    // convert hours to day portions
    func dayPortion(_ times: [Double]) -> [Double] {
        var timeAdjesment: [Double] = []
        for i in 0 ..< times.count {
            timeAdjesment.append(times[i] / 24)
        }
        return timeAdjesment
    }

    // Tune timings for adjustments
    // Set time offsets
    func tune(_ offsetTimes: [Double]) {
        for i in 0 ... offsets.count { // offsetTimes length
            // should be 7 in order
            // of Fajr, Sunrise,
            // Dhuhr, Asr, Sunset,
            // Maghrib, Isha
            offsets[i] = offsetTimes[i]
        }
    }

    open func tuneTimes(_ times: [Double]) -> [Double] {
        var aTimes: [Double] = []
        for i in 0 ..< times.count {
            aTimes.append(times[i] + offsets[i] / 60.0)
        }

        return aTimes
    }
}

extension Double {
    // ---------------------- Trigonometric Functions -----------------------
    // range reduce angle in degrees.
    static func fixAngle(_ a: Double) -> Double {
        let reduceAngle = a - (360 * (floor(a / 360.0)))
        let angle = reduceAngle < 0 ? (reduceAngle + 360) : reduceAngle

        return angle
    }

    // range reduce hours to 0..23
    static func fixHour(_ a: Double) -> Double {
        let reduceHour = a - 24.0 * floor(a / 24.0)
        let fixHour = reduceHour < 0 ? (reduceHour + 24) : reduceHour

        return fixHour
    }

    // radian to degree
    static func radiansToDegrees(_ alpha: Double) -> Double {
        return ((alpha * 180.0) / .pi)
    }

    // deree to radian
    static func degreesToRadians(_ alpha: Double) -> Double {
        return ((alpha * .pi) / 180.0)
    }

    // degree sin
    static func dSin(_ d: Double) -> Double {
        return (sin(degreesToRadians(d)))
    }

    // degree cos
    static func dCos(_ d: Double) -> Double {
        return (cos(degreesToRadians(d)))
    }

    // degree tan
    static func dTan(_ d: Double) -> Double {
        return (tan(degreesToRadians(d)))
    }

    // degree arcsin
    static func dArcSin(_ x: Double) -> Double {
        return radiansToDegrees(asin(x))
    }

    // degree arccos
    static func dArcCos(_ x: Double) -> Double {
        return radiansToDegrees(acos(x))
    }

    // degree arctan
    static func dArcTan(_ x: Double) -> Double {
        return radiansToDegrees(atan(x))
    }

    // degree arctan2
    static func dArcTan2(_ y: Double, x: Double) -> Double {
        return radiansToDegrees(atan2(y, x))
    }

    // degree arccot
    static func dArcCot(_ x: Double) -> Double {
        return radiansToDegrees(atan2(1.0, x))
    }
}
