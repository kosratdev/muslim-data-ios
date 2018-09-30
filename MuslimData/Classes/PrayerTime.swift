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
        return 0
    }
}
