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

    let dbRef: DBHelper
    public static let shared = MuslimData()

    // MARK: - Constractors

    private init() {
        dbRef = DBHelper.shared
    }

    // MARK: - Public Methods

    /// Get prayer times from the prayer database.
    ///
    /// - Parameters:
    ///   - city: City name
    ///   - date: Prayer times date
    ///   - callback: Callback that will returen the prayer time when it has been found in the database.
    public func getPrayerTimes(city: String, date: Date,
                               _ callback: @escaping (PrayerTime?, String?) -> Void) {
        let stringDate = formatPrayerDate(date)
        do {
            try dbRef.dbQueue?.inDatabase { dbConnect in
                let result = try Row.fetchOne(dbConnect, """
                    SELECT * FROM staticprayertimes where city = '\(cityMapper(city))' and date = '\(stringDate)'
                    """)
                guard let fajr = result?["fajr"] as? String,
                    let sunrise = result?["sunrise"] as? String,
                    let dhuhr = result?["dhuhr"] as? String,
                    let asr = result?["asr"] as? String,
                    let maghrib = result?["maghrib"] as? String,
                    let isha = result?["isha"] as? String else {
                        callback(nil, "Error:")
                        return
                }

                let prayerTime = PrayerTime(fajr: fajr.toDate(date),
                                            sunrise: sunrise.toDate(date),
                                            dhuhr: dhuhr.toDate(date),
                                            asr: asr.toDate(date),
                                            maghrib: maghrib.toDate(date),
                                            isha: isha.toDate(date))
                callback(prayerTime, nil)
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
