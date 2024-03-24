//
//  File.swift
//  
//
//  Created by Kosrat Ahmed on 24/03/2024.
//

@testable import MuslimData
import XCTest

class PrayerTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    func testPrayerTimesOffset() {
        var prayer = TestUtils.getPrayers()
        prayer.applyOffsets([1, 2, 3, 2, 1, 5])
        
        XCTAssertEqual(prayer.fajr, TestUtils.getDate(hour: 5, minute: 1, second: 0))
        XCTAssertEqual(prayer.sunrise, TestUtils.getDate(hour: 7, minute: 2, second: 0))
        XCTAssertEqual(prayer.dhuhr, TestUtils.getDate(hour: 12, minute: 3, second: 0))
        XCTAssertEqual(prayer.asr, TestUtils.getDate(hour: 15, minute: 2, second: 0))
        XCTAssertEqual(prayer.maghrib, TestUtils.getDate(hour: 18, minute: 1, second: 0))
        XCTAssertEqual(prayer.isha, TestUtils.getDate(hour: 19, minute: 5, second: 0))
    }
    
    func testFormatPrayers() {
        let prayer = TestUtils.getPrayers()
        let formattedPrayers = prayer.formatPrayers(.time12, locale: Locale(identifier: "en_US"))
        
        XCTAssertEqual(formattedPrayers[0], "05:00 AM")
        XCTAssertEqual(formattedPrayers[1], "07:00 AM")
        XCTAssertEqual(formattedPrayers[2], "12:00 PM")
        XCTAssertEqual(formattedPrayers[3], "03:00 PM")
        XCTAssertEqual(formattedPrayers[4], "06:00 PM")
        XCTAssertEqual(formattedPrayers[5], "07:00 PM")
    }
    
    func testPrayerSubscripts() {
        let prayer = TestUtils.getPrayers()
        
        XCTAssertEqual(prayer[0], TestUtils.getDate(hour: 5, minute: 0, second: 0))
        XCTAssertEqual(prayer[1], TestUtils.getDate(hour: 7, minute: 0, second: 0))
        XCTAssertEqual(prayer[2], TestUtils.getDate(hour: 12, minute: 0, second: 0))
        XCTAssertEqual(prayer[3], TestUtils.getDate(hour: 15, minute: 0, second: 0))
        XCTAssertEqual(prayer[4], TestUtils.getDate(hour: 18, minute: 0, second: 0))
        XCTAssertEqual(prayer[5], TestUtils.getDate(hour: 19, minute: 0, second: 0))
    }
}
