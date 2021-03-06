//
//  Location.swift
//  MuslimData_Example
//
//  Created by Kosrat D. Ahmad on 11/1/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import MuslimData

// MARK: - Location Extensions

extension Location {
    /// Save location in the User Defaults.
    func saveLocation() {
        let defaults = UserDefaults.standard
        defaults.set(latitude, forKey: "latitude")
        defaults.set(longitude, forKey: "longitude")
        defaults.set(city, forKey: "city")
        defaults.set(countryCode, forKey: "countryCode")
        defaults.set(countryName, forKey: "countryName")
        defaults.set(hasFixedPrayerTimes, forKey: "hasFixedPrayerTimes")
    }

    /// Load saved location from User Defaults.
    ///
    /// - Returns: Location object.
    static func loadSavedLocation() -> Location {
        let defaults = UserDefaults.standard
        var latitude = defaults.double(forKey: "latitude")
        latitude = latitude == 0.0 ? 36.188204 : latitude
        var longitude = defaults.double(forKey: "longitude")
        longitude = longitude == 0.0 ? 43.966606 : longitude
        let city = defaults.string(forKey: "city") ?? "Erbil"
        let countryCode = defaults.string(forKey: "countryCode") ?? "IQ"
        let countryName = defaults.string(forKey: "countryName") ?? "Iraq"
        let hasFixedPrayerTimes = (defaults.object(forKey: "hasFixedPrayerTimes") as? Bool) ?? true

        return Location(latitude: latitude, longitude: longitude, city: city, countryCode: countryCode,
                        countryName: countryName, hasFixedPrayerTimes: hasFixedPrayerTimes)
    }
}
