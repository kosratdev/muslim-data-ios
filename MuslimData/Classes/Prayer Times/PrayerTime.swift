//
//  PrayerTimes.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 9/28/18.
//

import Foundation

/// Prayer times object that will be use to get static prayer times from database.
public struct PrayerTime {
    // MARK: - Properties

    public var fajr: Date
    public var sunrise: Date
    public var dhuhr: Date
    public var asr: Date
    public var maghrib: Date
    public var isha: Date

    // MARK: - Public Methods

    /// Get prayer times from the prayer database.
    ///
    /// - Parameters:
    ///   - city: City name
    ///   - date: Prayer times date
    ///   - callback: Callback that will returen the prayer time when it has been found in the database.
    public static func getPrayerTimes(location: Location, date: Date, attributes: PrayerAttribute,
                                      callback: @escaping (PrayerTime?, String?) -> Void) {
        if !location.hasFixedPrayerTimes {
            let prayers = Prayer(method: attributes.method, asrJuristic: attributes.asrMethod,
                                 adjustHighLats: attributes.adjustAngle, timeFormat: .time24)
            let calculatedTimes = prayers.getPrayerTimes(date, latitude: location.latitude,
                                                         longitude: location.longitude)
            // Check calculated prayer times for nullability.
            guard let fajr = calculatedTimes["Fajr"], let sunrise = calculatedTimes["Sunrise"],
                let dhuhr = calculatedTimes["Dhuhr"], let asr = calculatedTimes["Asr"],
                let maghrib = calculatedTimes["Maghrib"], let isha = calculatedTimes["Isha"] else {
                callback(nil, "")
                return
            }

            let prayerTime = PrayerTime(fajr: fajr.toDate(date),
                                        sunrise: sunrise.toDate(date),
                                        dhuhr: dhuhr.toDate(date),
                                        asr: asr.toDate(date),
                                        maghrib: maghrib.toDate(date),
                                        isha: isha.toDate(date))
            callback(prayerTime, nil)
            return
        }

        DBHelper.shared.prayerTimes(countryCode: location.countryCode, city: location.city, date: date) { row, error in
            guard error == nil else {
                callback(nil, error)
                return
            }
            // Getting data from columns
            guard let fajr = row?["fajr"] as? String,
                let sunrise = row?["sunrise"] as? String,
                let dhuhr = row?["dhuhr"] as? String,
                let asr = row?["asr"] as? String,
                let maghrib = row?["maghrib"] as? String,
                let isha = row?["isha"] as? String else {
                callback(nil, "All columns are not found in the row.")
                return
            }

            // Create PrayerTime object.
            let prayerTime = PrayerTime(fajr: fajr.toDate(date),
                                        sunrise: sunrise.toDate(date),
                                        dhuhr: dhuhr.toDate(date),
                                        asr: asr.toDate(date),
                                        maghrib: maghrib.toDate(date),
                                        isha: isha.toDate(date))
            callback(prayerTime, nil)
        }
    }

    /// Format prayer times from Date object to String by "HH:mm" or "hh:mm a" pattern which
    /// depends on the given time format.
    ///
    /// - Parameter format: TimeFormat instance.
    /// - Returns: Array of formatted prayer times
    public func formatPrayers(_ format: TimeFormat) -> [String] {
        return [fajr.toTime(format: format), sunrise.toTime(format: format), dhuhr.toTime(format: format),
                asr.toTime(format: format), maghrib.toTime(format: format), isha.toTime(format: format)]
    }

    /// Get next prayer index and if all prayer times passed it will return 0.
    ///
    /// - Returns: Next prayer index
    public func nextPrayerIndex() -> Int {
        let prayers = [fajr, sunrise, dhuhr, asr, maghrib, isha]
        let now = Date()

        for index in 0 ..< prayers.count where prayers[index] > now {
            return index
        }
        return -1
    }

    /// Get next prayer remaining time interval
    ///
    /// - Returns: TimeInterval
    public func nextPrayerInterval() -> TimeInterval {
        let prayers = [fajr, sunrise, dhuhr, asr, maghrib, isha]
        let index = nextPrayerIndex()

        // If all prayer times passed then return remaining time interval for next Fajr prayer.
        if index == -1 {
            let calendar = Calendar.current
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: prayers[0])
            components.day = components.day! + 1
            let newFajr = calendar.date(from: components)!
            return newFajr.timeIntervalSinceNow
        }

        return prayers[index].timeIntervalSinceNow
    }

    /// Get next prayer remaining time with "HH:mm:ss" pattern.
    ///
    /// - Returns: String of next prayer remaining time.
    public func nextPrayerTimeRemaining() -> String {
        let time = nextPrayerInterval()
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
}
