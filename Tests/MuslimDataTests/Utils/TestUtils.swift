//
//  File.swift
//
//
//  Created by Kosrat Ahmed on 24/03/2024.
//

@testable import MuslimData
import Foundation

struct TestUtils {
    /// Generate date (2024/3/11 10:10:00). Also, gets value for each portion of the date.
    static func getDate(
        year: Int = 2024,
        month: Int = 3,
        day: Int = 11,
        hour: Int = 10,
        minute: Int = 10,
        second: Int = 0
    ) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        
        return Calendar.current.date(from: components)!
    }
    
    /// Generate a prayer time with following times:
    /// Fajr         = 05:00
    /// Sunrise   = 07:00
    /// Dhuhr     = 12:00
    /// Asr         = 15:00
    /// Maghrib = 18:00
    /// Isha       = 19:00
    static func getPrayers() -> PrayerTime {
        return PrayerTime(
            fajr: getDate(hour: 5, minute: 0, second: 0),
            sunrise: getDate(hour: 7, minute: 0, second: 0),
            dhuhr: getDate(hour: 12, minute: 0, second: 0),
            asr: getDate(hour: 15, minute: 0, second: 0),
            maghrib: getDate(hour: 18, minute: 0, second: 0),
            isha: getDate(hour: 19, minute: 0, second: 0)
        )
    }
}
