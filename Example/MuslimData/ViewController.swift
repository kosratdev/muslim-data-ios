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
        let attributes = PrayerAttribute(method: .makkah, asrMethod: .shafii, adjustAngle: .angleBased)
        PrayerTime.getPrayerTimes(location: location, date: Date(),
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
        LocationHelper.shared.cityHasFixedPrayerTimes(countryCode: "IQ", city: "Duhok") { (hasFixed) in
            print("City has fixed prayer times: \(hasFixed)")
        }

        // Get 99 names of allah from MuslimData library
        Names.names(language: .en) { names, error in
            guard error == nil else {
                print("Names of Allah didn't found: \(error!)")
                return
            }
            print("last name: \(names![98])")
        }

        // Get azkar categories from MuslimData library
        Azkars.azkarCategories(language: .en) { azkarCategories, error in
            guard error == nil else {
                print("Azkar categories didn't find: \(error!)")
                return
            }
            print("First Azkar Category Name: \(azkarCategories![0].name)")
        }

        // Get azkar chapters from MuslimData library
        Azkars.azkarChapters(language: .en) { azkarChapters, error in
            guard error == nil else {
                print("Azkar chapters didn't found: \(error!)")
                return
            }
            print("First Azkar Chapter Name: \(azkarChapters![0].name)")
        }

        // Get azkar chapters for a specific category from MuslimData library
        Azkars.azkarChapters(language: .en, categoryId: 2) { azkarChapters, error in
            guard error == nil else {
                print("Azkar chapters didn't found: \(error!)")
                return
            }
            print("Chapter name: \(azkarChapters![0].name) : for category id = \(azkarChapters![0].categoryId)")
        }

        // Get azkar items for a specific chapter from MuslimData library
        Azkars.azkarItems(language: .en, chapterId: 2) { azkarItems, error in
            guard error == nil else {
                print("Azkar items didn't found: \(error!)")
                return
            }
            print("First azkar item: \(azkarItems![0].item)")
        }
    }
}

