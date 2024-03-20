//
//  LocationTests.swift
//  MuslimData_Tests
//
//  Created by Kosrat D. Ahmad on 10/6/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

@testable import MuslimData
import XCTest

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
        locationHelper.geocoder(countryCode: "GB", locationName: "London") { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.latitude, 51.50853)
            XCTAssertEqual(location!.longitude, -0.12574)
            XCTAssertEqual(location!.hasFixedPrayerTime, true)
        }

        // Test Nil.
        locationHelper.geocoder(countryCode: "abc", locationName: "Unknown") { location in
            XCTAssertNil(location)
        }

        // Test (Tahran, IR) which hasn't fixed prayer times.
        locationHelper.geocoder(countryCode: "IR", locationName: "Tehran") { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.latitude, 35.69439)
            XCTAssertEqual(location!.longitude, 51.42151)
            XCTAssertEqual(location!.hasFixedPrayerTime, false)
        }

        // Test (Soran, IQ) which has fixed prayer times by city mapper.
        locationHelper.geocoder(countryCode: "IQ", locationName: "Soran") { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.latitude, 36.652686)
            XCTAssertEqual(location!.longitude, 44.541427)
            XCTAssertEqual(location!.hasFixedPrayerTime, true)
        }

        // Test (Qasre, IQ) which has fixed prayer times by city mapper.
        locationHelper.geocoder(countryCode: "IQ", locationName: "Qasre") { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.latitude, 36.557804)
            XCTAssertEqual(location!.longitude, 44.827805)
            XCTAssertEqual(location!.hasFixedPrayerTime, true)
        }
    }

    func testGeocoderLocation() {
        // Test (London, GB) which has fixed prayer times.
        locationHelper.reverseGeocoder(latitude: 51.50853, longitude: -0.12574) { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.name, "London")
            XCTAssertEqual(location!.countryCode, "GB")
            XCTAssertEqual(location!.countryName, "United Kingdom")
            XCTAssertEqual(location!.hasFixedPrayerTime, true)
        }

        // Test (Tahran, IR) which hasn't fixed prayer times.
        locationHelper.reverseGeocoder(latitude: 35.69439, longitude: 51.42151) { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.name, "Tehran")
            XCTAssertEqual(location!.countryCode, "IR")
            XCTAssertEqual(location!.countryName, "Iran")
            XCTAssertEqual(location!.hasFixedPrayerTime, false)
        }

        // Test (Soran, IQ) which has fixed prayer times by city mapper.
        locationHelper.reverseGeocoder(latitude: 36.652686, longitude: 44.541427) { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.name, "Soran")
            XCTAssertEqual(location!.countryCode, "IQ")
            XCTAssertEqual(location!.countryName, "Iraq")
            XCTAssertEqual(location!.hasFixedPrayerTime, true)
        }

        // Test (Qasre, IQ) which has fixed prayer times by city mapper.
        locationHelper.reverseGeocoder(latitude: 36.557804, longitude: 44.827805) { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.name, "Qasre")
            XCTAssertEqual(location!.countryCode, "IQ")
            XCTAssertEqual(location!.countryName, "Iraq")
            XCTAssertEqual(location!.hasFixedPrayerTime, true)
        }
    }
}
