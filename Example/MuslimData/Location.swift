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
        defaults.set(id, forKey: "id")
        defaults.set(name, forKey: "name")
        defaults.set(latitude, forKey: "latitude")
        defaults.set(longitude, forKey: "longitude")
        defaults.set(countryCode, forKey: "countryCode")
        defaults.set(countryName, forKey: "countryName")
        defaults.set(hasFixedPrayerTime, forKey: "hasFixedPrayerTime")
        defaults.set(prayerDependentId, forKey: "prayerDependentId")
    }

    /// Load saved location from User Defaults.
    ///
    /// - Returns: Location object.
    static func loadSavedLocation() -> Location {
        let defaults = UserDefaults.standard
        let id = defaults.integer(forKey: "id")
        let name = defaults.string(forKey: "name") ?? "Erbil"
        var latitude = defaults.double(forKey: "latitude")
        latitude = latitude == 0.0 ? 36.188204 : latitude
        var longitude = defaults.double(forKey: "longitude")
        longitude = longitude == 0.0 ? 43.966606 : longitude
        let countryCode = defaults.string(forKey: "countryCode") ?? "IQ"
        let countryName = defaults.string(forKey: "countryName") ?? "Iraq"
        let hasFixedPrayerTime = (defaults.object(forKey: "hasFixedPrayerTime") as? Bool) ?? true
        let prayerDependentId = defaults.object(forKey: "prayerDependentId") as? Int

        return Location(id: id, name: name, latitude: latitude, longitude: longitude,
                        countryCode: countryCode, countryName: countryName, hasFixedPrayerTime: hasFixedPrayerTime,
                        prayerDependentId: prayerDependentId)
    }
}
