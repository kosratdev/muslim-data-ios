//
//  DBHelper.swift
//  GRDB.swift
//
//  Created by Kosrat D. Ahmad on 9/27/18.
//

import GRDB
import UIKit

class DBHelper {
    // MARK: - Properties

    var dbPool: DatabasePool?
    static let shared = DBHelper()

    // MARK: - Life cycle

    private init() {
        let databaseURL = Bundle(for: DBHelper.self).path(forResource: "MuslimData", ofType: "db")!
        dbPool = try? DatabasePool(path: databaseURL)

        // Be a nice iOS citizen, and don’t consume too much memory
        // See https://github.com/groue/GRDB.swift/#memory-management
        dbPool?.setupMemoryManagement(in: UIApplication.shared)
    }

    // MARK: - Public Methods

    func prayerTimes(countryCode: String, city: String, date: Date, callback: @escaping (Row?, String?) -> Void) {
        do {
            try dbPool?.read { dbConnect in
                let result = try Row.fetchOne(dbConnect, """
                SELECT * FROM prayer_times
                WHERE country_code = '\(countryCode)' and city = '\(city.mapper(countryCode: countryCode))'
                and date = '\(formatPrayerDate(date))'
                """)
                guard let row = result else {
                    callback(nil, "Found nil while unwrapping result.")
                    return
                }
                callback(row, nil)
            }
        } catch {
            callback(nil, "Error: \(error.localizedDescription)")
        }
    }

    // MARK: - Private Methods

    /// Format date to "MM-dd" pattern which will be used to get prayers fro this date in the prayer database.
    ///
    /// - Parameter date: Date instance.
    /// - Returns: Formatted date by "MM-dd" pattern.
    private func formatPrayerDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "us")
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: date)
    }
}
