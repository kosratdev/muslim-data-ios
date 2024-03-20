//
//  NamesTest.swift
//  MuslimData_Tests
//
//  Created by Kosrat D. Ahmad on 10/12/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

@testable import MuslimData
import XCTest

class NamesTest: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEnglishNames() {
        Names.names(language: .en) { names, error in
            XCTAssertNil(error)
            XCTAssertNotNil(names)
            XCTAssertEqual(names!.count, 99)
        }
    }

    func testArabicNames() {
        Names.names(language: .ar) { names, error in
            XCTAssertNil(error)
            XCTAssertNotNil(names)
            XCTAssertEqual(names!.count, 99)
        }
    }

    func testKurdishNames() {
        Names.names(language: .ckb) { names, error in
            XCTAssertNil(error)
            XCTAssertNotNil(names)
            XCTAssertEqual(names!.count, 99)
        }
    }

    func testFarsiNames() {
        Names.names(language: .fa) { names, error in
            XCTAssertNil(error)
            XCTAssertNotNil(names)
            XCTAssertEqual(names!.count, 99)
        }
    }

    func testRussianNames() {
        Names.names(language: .ru) { names, error in
            XCTAssertNil(error)
            XCTAssertNotNil(names)
            XCTAssertEqual(names!.count, 99)
        }
    }
}
