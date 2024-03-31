//
//  String+Extensions.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 9/29/18.
//

import Foundation

extension String {
    /// Convert string time to date object.
    ///
    /// - Parameter date: Date which is used to the conversion.
    /// - Returns: Date object for the string time
    func toDate(_ date: Date) -> Date {
        let hourIndex = index(startIndex, offsetBy: 2)
        let hourFromTime = Int(self[..<hourIndex])!

        let minuteIndex = index(endIndex, offsetBy: -2)
        let minuteFromTime = Int(self[minuteIndex...])

        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        dateComponents.hour = hourFromTime
        dateComponents.minute = minuteFromTime

        return calendar.date(from: dateComponents)!
    }
}
