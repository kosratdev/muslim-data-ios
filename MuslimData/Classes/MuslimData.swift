//
//  MuslimData.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 9/28/18.
//

import Foundation
import GRDB

/// Time format enum that represents 12 hours or 24 hours time format.
///
/// - time12: 12 hours time format.
/// - time24: 24 hours time format.
public enum TimeFormat {
    case time12
    case time24
}

public class MuslimData {
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
            let prayers = Prayer(caculationmethod: attributes.calculationMethod, asrJuristic: attributes.asrMethod,
                                 adjustHighLats: attributes.adjustAngle, timeFormat: .time24)
            let calculatedTimes = prayers.getPrayerTimes(NSCalendar.current, latitude: location.latitude,
                                                         longitude: location.longitude, tZone: attributes.timeZone)
            // Check calculated prayer times for nullability.
            guard let fajr = calculatedTimes["Fajr"], let sunrise = calculatedTimes["Sunrise"],
                let dhuhr = calculatedTimes["Dhuhr"], let asr = calculatedTimes["Dhuhr"],
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
}
