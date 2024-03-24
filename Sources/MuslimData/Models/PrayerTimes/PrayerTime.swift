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

    // MARK: - Internal Methods

    /// Apply offests to the current prayer times.
    ///
    /// - Parameter offsets: List of double values as prayer offsets.
    mutating func applyOffsets(_ offsets: [Double]) {
        fajr = fajr.addMinutes(offsets[0])
        sunrise = sunrise.addMinutes(offsets[1])
        dhuhr = dhuhr.addMinutes(offsets[2])
        asr = asr.addMinutes(offsets[3])
        maghrib = maghrib.addMinutes(offsets[4])
        isha = isha.addMinutes(offsets[5])
    }

    /// Apply daylight saving time to the current prayer times.
    mutating func applyDST() {
        let isDST = TimeZone.current.isDaylightSavingTime()

        if isDST {
            fajr = fajr.addHours(1)
            sunrise = sunrise.addHours(1)
            dhuhr = dhuhr.addHours(1)
            asr = asr.addHours(1)
            maghrib = maghrib.addHours(1)
            isha = isha.addHours(1)
        }
    }

    // MARK: - Public Methods

    /// Format prayer times from Date object to String by "HH:mm" or "hh:mm a" pattern which
    /// depends on the given time format.
    ///
    /// - Parameter format: TimeFormat instance.
    /// - Returns: Array of formatted prayer times
    public func formatPrayers(_ format: TimeFormat) -> [String] {
        [fajr.toTime(format: format), sunrise.toTime(format: format), dhuhr.toTime(format: format),
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
