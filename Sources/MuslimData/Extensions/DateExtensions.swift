//
//  Date+Extensions.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 9/29/18.
//

import Foundation

extension Date {

    /// Format date to "MM-dd" pattern which will be used to get prayers fro this date in the prayer database.
    ///
    /// - Returns: Formatted date by "MM-dd" pattern.
    func toDBDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "us")
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: self)
    }

    /// Convert date to string time by given time format.
    ///
    /// - Parameter format: TimeFormat object.
    /// - Returns: Formatted date to string time.
    func format(format: TimeFormat, locale: Locale) -> String {
        return switch format {
        case .time24:
            formatTime24(locale: locale)
        case .time12:
            formatTime12(locale: locale)
        }
        
    }

    private func formatTime24(locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
    }
    
    private func formatTime12(locale: Locale) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.locale = locale
        return dateFormatter.string(from: self)
    }
    
    /// Add minutes to the date.
    ///
    /// - Parameter minutes: minutes to be added to the date.
    /// - Returns: New date that added the specified minutes.
    func addMinutes(_ minutes: Double) -> Date {
        addingTimeInterval(60 * minutes)
    }

    /// Add hours to the date.
    ///
    /// - Parameter hours: hours to be added to the date.
    /// - Returns: New date that added the specified hours.
    func addHours(_ hours: Double) -> Date {
        addingTimeInterval(60 * 60 * hours)
    }
}
