//
//  PrayerTests.swift
//  MuslimData_Tests
//
//  Created by Kosrat D. Ahmad on 10/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

@testable import MuslimData
import XCTest

class PrayerTimesTests: XCTestCase {
    var attributes: PrayerAttribute!
    var offsets: [Double]!

    override func setUp() {
        super.setUp()
        offsets = [1, 1, 1, -1, -1, -1]
        attributes = PrayerAttribute(method: .makkah, asrMethod: .shafii, adjustAngle: .angleBased, offsets: offsets)
    }

    override func tearDown() {
        attributes = nil
        super.tearDown()
    }

    func testAllFixedPrayerTimes() async throws {
        let locations = DBHelper.shared.fixedPrayerTimesList()
        let date = Date(timeIntervalSince1970: 1_709_206_718) // 2024/02/29
        for location in locations! {
            print(location)
            let prayerTimes = try await MuslimRepository().getPrayerTimes(location: location, date: date, attributes: attributes)
            XCTAssertNotNil(prayerTimes)
        }
    }

    func testCalculatedPrayer() async throws {
        // Test calculated prayer times for Mecca, Saudi Arabia
        let mecca = Location(id: 119_496, name: "Mecca", latitude: 21.42664, longitude: 39.82563, countryCode: "SA",
                             countryName: "Saudi Arabia", hasFixedPrayerTime: false, prayerDependentId: nil)
        let date = Date(timeIntervalSince1970: 1_538_956_800) // 2018/10/08
        let prayer = try await MuslimRepository().getPrayerTimes(location: mecca, date: date, attributes: attributes)

        XCTAssertNotNil(prayer)
        let stringPrayer = prayer!.formatPrayers(.time24)
        XCTAssertEqual(stringPrayer[0], "04:59")
        XCTAssertEqual(stringPrayer[1], "06:15")
        XCTAssertEqual(stringPrayer[2], "12:09")
        XCTAssertEqual(stringPrayer[3], "15:30")
        XCTAssertEqual(stringPrayer[4], "18:01")
        XCTAssertEqual(stringPrayer[5], "19:31")
    }
}
