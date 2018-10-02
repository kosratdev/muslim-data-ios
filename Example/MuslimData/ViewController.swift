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
        let attributes = PrayerAttribute(calculationMethod: .makkah, asrMethod: .shafii, adjustAngle: .angleBased,
                                         latitude: 36.123, longitude: 44.123, timeZone: 3.0)
        MuslimData.getPrayerTimes(city: "Soran", date: Date(),
                                         isStatic: false, attributes: attributes) { (prayerTime, error) in
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
    }
}

