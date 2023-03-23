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
            XCTAssertEqual(location!.hasFixedPrayerTime, true)
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
            XCTAssertEqual(location!.hasFixedPrayerTime, false)
        }

        // Test (Soran, IQ) which has fixed prayer times by city mapper.
        locationHelper.geocoder(countryCode: "IQ", city: "Soran") { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.latitude, 36.652686)
            XCTAssertEqual(location!.longitude, 44.541427)
            XCTAssertEqual(location!.hasFixedPrayerTime, true)
        }
    }

    func testGeocoderLocation() {
        // Test (London, GB) which has fixed prayer times.
        locationHelper.geocoder(latitude: 51.50853, longitude: -0.12574) { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.cityName, "London")
            XCTAssertEqual(location!.countryCode, "GB")
            XCTAssertEqual(location!.countryName, "United Kingdom")
            XCTAssertEqual(location!.hasFixedPrayerTime, true)
        }

        // Test (Tahran, IR) which hasn't fixed prayer times.
        locationHelper.geocoder(latitude: 35.69439, longitude: 51.42151) { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.cityName, "Tehran")
            XCTAssertEqual(location!.countryCode, "IR")
            XCTAssertEqual(location!.countryName, "Iran")
            XCTAssertEqual(location!.hasFixedPrayerTime, false)
        }

        // Test (Soran, IQ) which has fixed prayer times by city mapper.
        locationHelper.geocoder(latitude: 36.652686, longitude: 44.541427) { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.cityName, "Soran")
            XCTAssertEqual(location!.countryCode, "IQ")
            XCTAssertEqual(location!.countryName, "Iraq")
            XCTAssertEqual(location!.hasFixedPrayerTime, true)
        }
    }

    func testCityMapper() {
        XCTAssertEqual("Sulav".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Mamuzin".mapper(countryCode: "IQ"), "Bardarash")
        XCTAssertEqual("Zarayan".mapper(countryCode: "IQ"), "Darbandikhan")
        XCTAssertEqual("Atrish".mapper(countryCode: "IQ"), "Duhok")
        XCTAssertEqual("Choman".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Byara".mapper(countryCode: "IQ"), "Khurmal")
        XCTAssertEqual("Ranya".mapper(countryCode: "IQ"), "Chamchamal")
        XCTAssertEqual("Taza Khurmatu".mapper(countryCode: "IQ"), "Kirkuk")
        XCTAssertEqual("Khalakan".mapper(countryCode: "IQ"), "Chamchamal")
        XCTAssertEqual("Sangasar".mapper(countryCode: "IQ"), "Qaladiza")
        XCTAssertEqual("Takiya".mapper(countryCode: "IQ"), "Kifri")
        XCTAssertEqual("Divandarreh".mapper(countryCode: "IR"), "Sanandaj")
        XCTAssertEqual("Rai".mapper(countryCode: "KW"), "Al Asimah")
        XCTAssertEqual("Kubbar Island".mapper(countryCode: "KW"), "Failaka Island")
        XCTAssertEqual("Jahra".mapper(countryCode: "KW"), "Abdali")
    }
}
