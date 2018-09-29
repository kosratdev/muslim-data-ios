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
        // Do any additional setup after loading the view, typically from a nib.

        MuslimData.shared.getPrayerTimes(city: "Soran", date: Date(), format: .time24) { (prayerTime, error) in
            guard error == nil else {
                print("Prayer tims didn't found for the specified properties.")
                return
            }
            print("prayer time: \(prayerTime!)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

