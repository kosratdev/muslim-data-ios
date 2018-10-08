//
//  PrayerTests.swift
//  MuslimData_Tests
//
//  Created by Kosrat D. Ahmad on 10/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import MuslimData

class PrayerTests: XCTestCase {

    var attributes: PrayerAttribute!
    var date: Date!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        date = Date(timeIntervalSince1970: 1538956800) // 2018/10/08
        attributes = PrayerAttribute(calculationMethod: .makkah, asrMethod: .shafii,
                                     adjustAngle: .angleBased, timeZone: 3.0)
    }

    override func tearDown() {
        date = nil
        attributes = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFixedPrayer() {
        // Test fixed prayer times for Sulav, Iraq
        let sulav = Location(latitude: 0.0, longitude: 0.0, city: "Sulav", countryCode: "IQ",
                             countryName: "Iraq", hasFixedPrayerTimes: true)
        PrayerTime.getPrayerTimes(location: sulav, date: date, attributes: attributes) { prayer, error in
            XCTAssertNil(error)
            XCTAssertNotNil(prayer)
            let stringPrayer = prayer!.formatPrayers(.time24)
            XCTAssertEqual(stringPrayer[0], "04:45")
            XCTAssertEqual(stringPrayer[1], "06:10")
            XCTAssertEqual(stringPrayer[2], "11:58")
            XCTAssertEqual(stringPrayer[3], "15:14")
            XCTAssertEqual(stringPrayer[4], "17:44")
            XCTAssertEqual(stringPrayer[5], "18:59")
        }

        // Test fixed prayer times for Erbil, Iraq
        let erbil = Location(latitude: 0.0, longitude: 0.0, city: "Erbil", countryCode: "IQ",
                             countryName: "Iraq", hasFixedPrayerTimes: true)
        PrayerTime.getPrayerTimes(location: erbil, date: date, attributes: attributes) { prayer, error in
            XCTAssertNil(error)
            XCTAssertNotNil(prayer)
            let stringPrayer = prayer!.formatPrayers(.time24)
            XCTAssertEqual(stringPrayer[0], "04:41")
            XCTAssertEqual(stringPrayer[1], "06:09")
            XCTAssertEqual(stringPrayer[2], "12:01")
            XCTAssertEqual(stringPrayer[3], "15:11")
            XCTAssertEqual(stringPrayer[4], "17:42")
            XCTAssertEqual(stringPrayer[5], "18:57")
        }

        // Test fixed prayer times for Baghdad, Iraq
        let baghdad = Location(latitude: 0.0, longitude: 0.0, city: "Baghdad", countryCode: "IQ",
                             countryName: "Iraq", hasFixedPrayerTimes: true)
        PrayerTime.getPrayerTimes(location: baghdad, date: date, attributes: attributes) { prayer, error in
            XCTAssertNil(error)
            XCTAssertNotNil(prayer)
            let stringPrayer = prayer!.formatPrayers(.time24)
            XCTAssertEqual(stringPrayer[0], "04:33")
            XCTAssertEqual(stringPrayer[1], "06:02")
            XCTAssertEqual(stringPrayer[2], "11:57")
            XCTAssertEqual(stringPrayer[3], "15:15")
            XCTAssertEqual(stringPrayer[4], "17:41")
            XCTAssertEqual(stringPrayer[5], "18:59")
        }

        // Test fixed prayer times for Sanandaj, Iran
        let sanandaj = Location(latitude: 0.0, longitude: 0.0, city: "Sanandaj", countryCode: "IR",
                             countryName: "Iran", hasFixedPrayerTimes: true)
        PrayerTime.getPrayerTimes(location: sanandaj, date: date, attributes: attributes) { prayer, error in
            XCTAssertNil(error)
            XCTAssertNotNil(prayer)
            let stringPrayer = prayer!.formatPrayers(.time24)
            XCTAssertEqual(stringPrayer[0], "04:57")
            XCTAssertEqual(stringPrayer[1], "06:22")
            XCTAssertEqual(stringPrayer[2], "12:28")
            XCTAssertEqual(stringPrayer[3], "15:28")
            XCTAssertEqual(stringPrayer[4], "18:05")
            XCTAssertEqual(stringPrayer[5], "19:15")
        }
    }

    func testCalculatedPrayer() {
        // Test calculated prayer times for Mecca, Saudi Arabia
        let mecca = Location(latitude: 21.42664, longitude: 39.82563, city: "Mecca", countryCode: "SA",
                             countryName: "Saudi Arabia", hasFixedPrayerTimes: false)
        PrayerTime.getPrayerTimes(location: mecca, date: date, attributes: attributes) { prayer, error in
            XCTAssertNil(error)
            XCTAssertNotNil(prayer)
            let stringPrayer = prayer!.formatPrayers(.time24)
            XCTAssertEqual(stringPrayer[0], "04:58")
            XCTAssertEqual(stringPrayer[1], "06:14")
            XCTAssertEqual(stringPrayer[2], "12:08")
            XCTAssertEqual(stringPrayer[3], "15:31")
            XCTAssertEqual(stringPrayer[4], "18:02")
            XCTAssertEqual(stringPrayer[5], "19:32")
        }
    }
}
