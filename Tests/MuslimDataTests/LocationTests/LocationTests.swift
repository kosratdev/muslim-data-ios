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
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLondonGBGeocod() async throws {
        // Test (London, GB) which has fixed prayer times.
        let location = try await MuslimRepository().geocoder(countryCode: "GB", locationName: "London")
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.latitude, 51.50853)
        XCTAssertEqual(location!.longitude, -0.12574)
        XCTAssertEqual(location!.hasFixedPrayerTime, true)
    }

    func testUnknownGeocode() async throws {
        // Test Nil.
        let location = try await MuslimRepository().geocoder(countryCode: "abc", locationName: "Unknown")
        XCTAssertNil(location)
    }

    func testTehranIRGeocode() async throws {
        // Test (Tahran, IR) which hasn't fixed prayer times.
        let location = try await MuslimRepository().geocoder(countryCode: "IR", locationName: "Tehran")
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.latitude, 35.69439)
        XCTAssertEqual(location!.longitude, 51.42151)
        XCTAssertEqual(location!.hasFixedPrayerTime, false)
    }

    func testSoranIQGeocode() async throws {
        // Test (Soran, IQ) which has fixed prayer times.
        let location = try await MuslimRepository().geocoder(countryCode: "IQ", locationName: "Soran")
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.latitude, 36.652686)
        XCTAssertEqual(location!.longitude, 44.541427)
        XCTAssertEqual(location!.hasFixedPrayerTime, true)
    }

    func testQasreIQGeocode() async throws {
        // Test (Qasre, IQ) which has fixed prayer times.
        let location = try await MuslimRepository().geocoder(countryCode: "IQ", locationName: "Qasre")
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.latitude, 36.557804)
        XCTAssertEqual(location!.longitude, 44.827805)
        XCTAssertEqual(location!.hasFixedPrayerTime, true)
    }

    func testLondonGBReverseGeocode() async throws {
        // Test (London, GB) which has fixed prayer times.
        let location = try await MuslimRepository().reverseGeocoder(latitude: 51.50853, longitude: -0.12574)
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.name, "London")
        XCTAssertEqual(location!.countryCode, "GB")
        XCTAssertEqual(location!.countryName, "United Kingdom")
        XCTAssertEqual(location!.hasFixedPrayerTime, true)
    }

    func testTehranIRReverseGeocode() async throws {
        // Test (Tahran, IR) which hasn't fixed prayer times.
        let location = try await MuslimRepository().reverseGeocoder(latitude: 35.69439, longitude: 51.42151)
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.name, "Tehran")
        XCTAssertEqual(location!.countryCode, "IR")
        XCTAssertEqual(location!.countryName, "Iran")
        XCTAssertEqual(location!.hasFixedPrayerTime, false)
    }

    func testSoranIQReverseGeocode() async throws {
        // Test (Soran, IQ) which has fixed prayer times.
        let location = try await MuslimRepository().reverseGeocoder(latitude: 36.652686, longitude: 44.541427)
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.name, "Soran")
        XCTAssertEqual(location!.countryCode, "IQ")
        XCTAssertEqual(location!.countryName, "Iraq")
        XCTAssertEqual(location!.hasFixedPrayerTime, true)
    }

    func testQasreIQReverseGeocode() async throws {
        // Test (Qasre, IQ) which has fixed prayer times.
        let location = try await MuslimRepository().reverseGeocoder(latitude: 36.557804, longitude: 44.827805)
        XCTAssertNotNil(location)
        XCTAssertEqual(location!.name, "Qasre")
        XCTAssertEqual(location!.countryCode, "IQ")
        XCTAssertEqual(location!.countryName, "Iraq")
        XCTAssertEqual(location!.hasFixedPrayerTime, true)
    }
}
