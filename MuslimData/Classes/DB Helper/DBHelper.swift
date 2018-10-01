//
//  DBHelper.swift
//  GRDB.swift
//
//  Created by Kosrat D. Ahmad on 9/27/18.
//

import UIKit
import GRDB

class DBHelper {
    // MARK: - Properties

    var dbQueue: DatabaseQueue?
    static let shared = DBHelper()

    // MARK: - Life cycle

    private init() {
        let databaseURL = Bundle(for: DBHelper.self).path(forResource: "PrayersDb", ofType: "db")!
        dbQueue = try? DatabaseQueue(path: databaseURL)

        // Be a nice iOS citizen, and don’t consume too much memory
        // See https://github.com/groue/GRDB.swift/#memory-management
        dbQueue?.setupMemoryManagement(in: UIApplication.shared)
    }

    // MARK: - Public Methods

    func prayerTimes(city: String, date: Date, callback: @escaping (Row?, String?) -> Void) {
        do {
            try dbQueue?.inDatabase { dbConnect in
                let result = try Row.fetchOne(dbConnect, """
                    SELECT * FROM staticprayertimes where city = '\(cityMapper(city))'
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

    /// City mapper that finds parent city if it has and it is used in the static prayers.
    ///
    /// - Parameter city: Current city.
    /// - Returns: Parent city.
    private func cityMapper(_ city: String) -> String {
        let city = city.capitalized
        let cities = ["Akre": ["Amedi", "Sulav", "Kani", "Sheladiz", "Barzan", "Bele", "Shanidar", "Bujal", "Mergin",
                               "Susna", "Sersink"],
                      "Bardarash": ["Mamuzin"],
                      "Darbandikhan": ["Zarayan"],
                      "Duhok": ["Sumel", "Zawita", "Atrish", "Sharya", "Mrebah"],
                      "Erbil": ["Kalak", "Pirmam", "Shaqlawa", "Harir", "Khalifan", "Rawanduz", "Soran", "Mergasur",
                                "Galala", "Choman", "Hiran", "Makhmur", "Qushtapa", "Kasnazan"],
                      "Halabja": ["Khurmal", "Sirwan", "Byara", "Tawella"],
                      "Kifri": ["Hajiawa", "Chwarqurna", "Ranya"],
                      "Kirkuk": ["Taza Khurmatu"],
                      "Koysinjaq": ["Taqtaq", "Khalakan"],
                      "Qalat Dizah": ["Sangasar", "Zharawa"],
                      "Sulaymaniyah": ["Dokan", "Bazian", "Chamchamal", "Qaran Dagh", "Arbat", "Penjwen", "Said Sadiq",
                                       "Kalar", "Takiya", "Shorsh"],
                      "Kamyaran": ["Divandarreh"],
                      "Al Asimah": ["Kuwait City", "Dasman Palace", "Sharq", "Mirqab", "Jibla", "Dasma", "Daiya",
                                    "Salhia", "Bneid Al Qar", "Kaifan", "Mansouriya", "Abdullah al-Salem", "Nuzha",
                                    "Faiha", "Shamiya", "Rawda", "Adailiya", "Khaldiya", "Qadsiya", "Qortuba", "Surra",
                                    "Yarmouk", "Shuwaikh Industrial", "Rai", "Granada", "Sulaibikhat", "Doha",
                                    "Nahdha", "Jaber Al Ahmad", "Qairawan", "Ahmadi", "Al Wafrah", "Sabah Al Salem",
                                    "Messila", "Al-Masayel", "Adan", "Fnaitees", "Qusor", "Qurain", "Abu Fatira",
                                    "Mubarak Al Kabeer", "Jeleeb Al-Shuyoukh", "Eqaila", "Fintas", "Dahar", "Mahboula",
                                    "Hadiya", "Al-Riqqa", "Abu Halifa", "Fahad Al Ahmad", "Assabahiyah", "Mangaf",
                                    "Fahaheel", "South Sabahiya", "Ali Sabah Al Salem", "Shalayhat Mina Abdullah",
                                    "Zour", "Al Khiran"],
                      "Failaka Island": ["Zoor", "Kubbar Island", "Al-Nuwaiseeb"],
                      "Abdali": ["Jahra"]]

        var parentCity: String?
        cities.forEach { key, values in
            if values.contains(city) {
                parentCity = key
            }
        }
        return parentCity ?? city
    }
}
