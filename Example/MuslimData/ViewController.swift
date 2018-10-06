//
//  ViewController.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 09/27/2018.
//  Copyright (c) 2018 Kosrat D. Ahmad. All rights reserved.
//

import UIKit
import MuslimData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Get prayer times from the MuslimData library
        let location = Location(latitude: 36.123, longitude: 44.123, city: "Erbil", countryCode: "IQ",
                                countryName: "Iraq", hasFixedPrayerTimes: true)
        let attributes = PrayerAttribute(calculationMethod: .makkah, asrMethod: .shafii,
                                         adjustAngle: .angleBased, timeZone: 3.0)
        MuslimData.getPrayerTimes(location: location, date: Date(),
                                  attributes: attributes) { (prayerTime, error) in
            guard error == nil else {
                print("Prayer tims didn't found for the specified properties.")
                return
            }
            print("prayer times: \(prayerTime!)")
            print("Fromat prayer times: \(prayerTime!.formatPrayers(.time12))")
            print("Format one prayer time: \(prayerTime!.isha.toTime(format: .time24))")
            print("next prayer index: \(prayerTime!.nextPrayerIndex())")
            print("next prayer interval: \(prayerTime!.nextPrayerInterval())")
            print("next prayer time remaining: \(prayerTime!.nextPrayerTimeRemaining())")
        }

        // Use geocoder to find city location by name.
        LocationHelper.shared.geocoder(countryCode: "GB", city: "London") { location in
            guard let location = location else {
                print("City name can not be geocoder")
                return
            }
            print("location: \(location)")
        }

        // Use reverse geocoder to find city name by latitude and longitude.
        LocationHelper.shared.geocoder(latitude: 36.654090, longitude: 44.541278) { (location) in
            guard let location = location else {
                print("City name can nnot be geocoder by latitude and longitude")
                return
            }
            print("location: \(location)")
        }

        // Check a city to know that it has fixed prayer times or not
        LocationHelper.shared.cityHasFixedPrayerTimes(city: "Duhok") { (hasFixed) in
            print("City has fixed prayer times: \(hasFixed)")
        }
    }
}

