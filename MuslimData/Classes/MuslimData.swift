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
    // MARK: - Properties

    public static let shared = MuslimData()

    // MARK: - Constractors

    private init() {}

    // MARK: - Public Methods

    /// Get prayer times from the prayer database.
    ///
    /// - Parameters:
    ///   - city: City name
    ///   - date: Prayer times date
    ///   - callback: Callback that will returen the prayer time when it has been found in the database.
    public func getPrayerTimes(city: String, date: Date, _ callback: @escaping (PrayerTime?, String?) -> Void) {
        DBHelper.shared.prayerTimes(city: city, date: date) { row, error in
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
