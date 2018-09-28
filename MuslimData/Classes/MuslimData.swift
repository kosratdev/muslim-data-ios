//
//  MuslimData.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 9/28/18.
//

import Foundation

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

    // MARK: - Constractors

    public init() {
        dbRef = DBHelper.shared
    }

    // MARK: - Public Methods

    /// Get prayer times from the prayer database.
    ///
    /// - Parameters:
    ///   - city: City name
    ///   - date: Prayer times date
    ///   - format: Prayer times format that should be on of time12 or time24.
    ///   - callback: Callback that will returen the prayer time when it has been found in the database.
    public func getPrayerTimes(city: String, date: Date, format: TimeFormat,
                        _ callback: @escaping (PrayerTime?, String?) -> Void) {
        let date = formatPrayerDate(date)
            do {
                try dbRef.dbQueue?.inDatabase { dbConnect in
                    let result = try PrayerTime.fetchOne(dbConnect, """
                        SELECT * FROM staticprayertimes where city = '\(cityMapper(city))' and date = '\(date)'
                        """)
                    guard var prayerTime = result else {
                        callback(nil, "Error:")
                        return
                    }

                    if format == .time12 {
                        prayerTime.fajr = formatToTime12(prayerTime.fajr)
                        prayerTime.sunrise = formatToTime12(prayerTime.sunrise)
                        prayerTime.zuhr = formatToTime12(prayerTime.zuhr)
                        prayerTime.asr = formatToTime12(prayerTime.asr)
                        prayerTime.maghrib = formatToTime12(prayerTime.maghrib)
                        prayerTime.isha = formatToTime12(prayerTime.isha)
                    }
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

    /// Convert 24 hours time format to 12 hours time format.
    ///
    /// - Parameter time: 24 Hours time format.
    /// - Returns: 12 Hours time format.
    private func formatToTime12(_ time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: time)!
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
}
