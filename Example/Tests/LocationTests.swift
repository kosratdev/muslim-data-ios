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

    func testGeocoderLocation() {
        // Test (London, GB) which has fixed prayer times.
        locationHelper.geocoder(latitude: 51.50853, longitude: -0.12574) { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.city, "London")
            XCTAssertEqual(location!.countryCode, "GB")
            XCTAssertEqual(location!.countryName, "United Kingdom")
            XCTAssertEqual(location!.hasFixedPrayerTimes, true)
        }

        // Test (Tahran, IR) which hasn't fixed prayer times.
        locationHelper.geocoder(latitude: 35.69439, longitude: 51.42151) { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.city, "Tehran")
            XCTAssertEqual(location!.countryCode, "IR")
            XCTAssertEqual(location!.countryName, "Iran")
            XCTAssertEqual(location!.hasFixedPrayerTimes, false)
        }

        // Test (Soran, IQ) which has fixed prayer times by city mapper.
        locationHelper.geocoder(latitude: 36.652686, longitude: 44.541427) { location in
            XCTAssertNotNil(location)
            XCTAssertEqual(location!.city, "Soran")
            XCTAssertEqual(location!.countryCode, "IQ")
            XCTAssertEqual(location!.countryName, "Iraq")
            XCTAssertEqual(location!.hasFixedPrayerTimes, true)
        }
    }

    func testFixedPrayerTimes() {
        // Test (Soran, IQ) which has fixed prayer times
        locationHelper.cityHasFixedPrayerTimes(countryCode: "IQ", city: "Soran") { hasFixed in
            XCTAssertTrue(hasFixed)
        }

        // Test (Tehran, IR) which hasn't fixed prayer times
        locationHelper.cityHasFixedPrayerTimes(countryCode: "IR", city: "Tehran") { hasFixed in
            XCTAssertFalse(hasFixed)
        }

        // Test (Urmia, IR) which has fixed prayer times
        locationHelper.cityHasFixedPrayerTimes(countryCode: "IR", city: "Urmia") { hasFixed in
            XCTAssertTrue(hasFixed)
        }

        // Test (Homs, SY) which has fixed prayer times
        locationHelper.cityHasFixedPrayerTimes(countryCode: "SY", city: "Homs") { hasFixed in
            XCTAssertTrue(hasFixed)
        }
    }

    func testCityMapper() {
        XCTAssertEqual("Sulav".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Mamuzin".mapper(countryCode: "IQ"), "Bardarash")
        XCTAssertEqual("Zarayan".mapper(countryCode: "IQ"), "Darbandikhan")
        XCTAssertEqual("Atrish".mapper(countryCode: "IQ"), "Duhok")
        XCTAssertEqual("Choman".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Byara".mapper(countryCode: "IQ"), "Halabja")
        XCTAssertEqual("Ranya".mapper(countryCode: "IQ"), "Kifri")
        XCTAssertEqual("Taza Khurmatu".mapper(countryCode: "IQ"), "Kirkuk")
        XCTAssertEqual("Khalakan".mapper(countryCode: "IQ"), "Koysinjaq")
        XCTAssertEqual("Sangasar".mapper(countryCode: "IQ"), "Qalat Dizah")
        XCTAssertEqual("Takiya".mapper(countryCode: "IQ"), "Sulaymaniyah")
        XCTAssertEqual("Divandarreh".mapper(countryCode: "IR"), "Sanandaj")
        XCTAssertEqual("Rai".mapper(countryCode: "KW"), "Al Asimah")
        XCTAssertEqual("Kubbar Island".mapper(countryCode: "KW"), "Failaka Island")
        XCTAssertEqual("Jahra".mapper(countryCode: "KW"), "Abdali")
    }
}
