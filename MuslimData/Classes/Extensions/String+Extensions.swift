//
//  String+Extensions.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 9/29/18.
//

import Foundation

// MARK: - String Extensions

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

    /// City mapper that finds parent city if it has and it is used in the fixed prayers.
    ///
    /// - Parameter countryCode: Country code
    /// - Returns: Parent city if available else the city it self.
    func mapper(countryCode: String) -> String {
        let city = self
        var parentCity: String?
        if let path = Bundle(for: DBHelper.self).path(forResource: "cityMapper", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any]
                if let jsonResult = jsonResult, let cities = jsonResult[countryCode] as? [String: [String]] {
                    cities.forEach { key, values in
                        if values.contains(city) {
                            parentCity = key
                        }
                    }
                }

            } catch {
                return city
            }
        }
        return parentCity ?? city
    }
}
