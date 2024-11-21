//
//  File.swift
//  
//
//  Created by Kosrat Ahmed on 24/03/2024.
//

@testable import MuslimData
import XCTest

class DateFormatTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testToDBDate() {
        XCTAssertEqual(TestUtils.getDate().toDBDate(), "03-11")
    }
    
    func testEnFormatTime24() {
        XCTAssertEqual(TestUtils.getDate().format(format: .time24, locale: Locale(identifier: "en_US")), "10:10")
    }
    
    func testArFormatTime24() {
        XCTAssertEqual(TestUtils.getDate().format(format: .time24, locale: Locale(identifier: "ar@numbers=arab")), "١٠:١٠")
    }
    
    func testCkbFormatTime24() {
        XCTAssertEqual(TestUtils.getDate().format(format: .time24, locale: Locale(identifier: "ckb")), "١٠:١٠")
    }
    
    func testCkbBadiniFormatTime24() {
        XCTAssertEqual(TestUtils.getDate().format(format: .time24, locale: Locale(identifier: "ckb_BADINI")), "١٠:١٠")
    }
    
    func testEnFormatTime12() {
        XCTAssertEqual(TestUtils.getDate().format(format: .time12, locale: Locale(identifier: "en_US")), "10:10 AM")
        XCTAssertEqual(TestUtils.getDate().addHours(12).format(format: .time12, locale: Locale(identifier: "en_US")), "10:10 PM")
    }
    
    func testArFormatTime12() {
        XCTAssertEqual(TestUtils.getDate().format(format: .time12, locale: Locale(identifier: "ar@numbers=arab")), "١٠:١٠ ص")
        XCTAssertEqual(TestUtils.getDate().addHours(12).format(format: .time12, locale: Locale(identifier: "ar@numbers=arab")), "١٠:١٠ م")
    }
    
    func testCkbFormatTime12() {
        XCTAssertEqual(TestUtils.getDate().format(format: .time12, locale: Locale(identifier: "ckb")), "١٠:١٠ ب.ن")
        XCTAssertEqual(TestUtils.getDate().addHours(12).format(format: .time12, locale: Locale(identifier: "ckb")), "١٠:١٠ د.ن")
    }
    
    func testCkbBadiniFormatTime12() {
        XCTAssertEqual(TestUtils.getDate().format(format: .time12, locale: Locale(identifier: "ckb_BADINI")), "١٠:١٠ ب.ن")
        XCTAssertEqual(TestUtils.getDate().addHours(12).format(format: .time12, locale: Locale(identifier: "ckb_BADINI")), "١٠:١٠ د.ن")
    }
    
    func testStringToDate() {
        let actualDate = TestUtils.getDate(year: 2024, month: 3, day: 11, hour: 15, minute: 15, second: 0)
        XCTAssertEqual("15:15".toDate(TestUtils.getDate()), actualDate)
        XCTAssertEqual("10:10".toDate(TestUtils.getDate(hour: 11, minute: 15)), TestUtils.getDate())
    }
    
    func testAddHoursToDate() {
        XCTAssertEqual(TestUtils.getDate().addHours(5), TestUtils.getDate(hour: 15))
    }
    
    func testAddMinutesToDate() {
        XCTAssertEqual(TestUtils.getDate().addMinutes(5), TestUtils.getDate(minute: 15))
    }
}
