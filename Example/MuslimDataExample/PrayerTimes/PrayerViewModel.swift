//
//  PrayerViewModel.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import Foundation
import MuslimData

@Observable
/// Manages the state for the prayer times and responsible for fetching data.
class PrayerViewModel {
    private(set) var location: Location
    private(set) var prayerTimes: [String] = []
    private(set) var prayerNames = ["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"]

    init() {
        location = Location.loadSavedLocation()
        getPrayerTimes()
    }
    
    /// Fetches the prayer times from the `MuslimRepository` and then assign it to the local variable.
    private func getPrayerTimes() {
        Task {
            do {
                let offsets: [Double] = [0, 0, 0, 0, 0, 0]
                let prayerAttribute = PrayerAttribute(method: .makkah, asrMethod: .shafii, adjustAngle: .angleBased, offsets: offsets)
                let prayer = try await MuslimRepository().getPrayerTimes(location: location, date: Date(), attributes: prayerAttribute)
                prayerTimes = prayer?.formatPrayers(.time12) ?? []
            } catch {
                print("Error Loading prayer times: \(error.localizedDescription)")
            }
        }
    }
    
    /// Formate today's date as `dd MMM yyyy` and return it as string.
    /// - Returns: Formatted today's date.
    func todayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: Date())
    }
}
