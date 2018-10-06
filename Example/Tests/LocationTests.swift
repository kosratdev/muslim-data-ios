//
//  LocationTests.swift
//  MuslimData_Tests
//
//  Created by Kosrat D. Ahmad on 10/6/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import MuslimData

class LocationTests: XCTestCase {

    var locationHelper: LocationHelper!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        locationHelper = LocationHelper.shared
    }

    override func tearDown() {
        locationHelper = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGeocoderName() {
        // Test (London, GB) which has fixed prayer times.
        locationHelper.geocoder(countryCode: "GB", city: "London") { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.latitude, 51.50853)
            XCTAssertEqual(location!.longitude, -0.12574)
            XCTAssertEqual(location!.hasFixedPrayerTimes, true)
        }

        // Test Nil.
        locationHelper.geocoder(countryCode: "abc", city: "Unknown") { location in
            XCTAssertNil(location)
        }

        // Test (Tahran, IR) which hasn't fixed prayer times.
        locationHelper.geocoder(countryCode: "IR", city: "Tehran") { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.latitude, 35.69439)
            XCTAssertEqual(location!.longitude, 51.42151)
            XCTAssertEqual(location!.hasFixedPrayerTimes, false)
        }

        // Test (Soran, IQ) which has fixed prayer times by city mapper.
        locationHelper.geocoder(countryCode: "IQ", city: "Soran") { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.latitude, 36.652686)
            XCTAssertEqual(location!.longitude, 44.541427)
            XCTAssertEqual(location!.hasFixedPrayerTimes, true)
        }
    }
}
