//
//  AzkarTests.swift
//  MuslimData_Tests
//
//  Created by Kosrat D. Ahmad on 10/13/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import MuslimData

class AzkarTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAzkarCategories() {
        // Test English azkar categories
        Azkars.azkarCategories(language: .en) { categories, error in
            XCTAssertNil(error)
            XCTAssertNotNil(categories)
            XCTAssertEqual(categories!.count, 11)
            XCTAssertNotNil(categories![5].name)
        }

        // Test Arabic azkar categories
        Azkars.azkarCategories(language: .ar) { categories, error in
            XCTAssertNil(error)
            XCTAssertNotNil(categories)
            XCTAssertEqual(categories!.count, 11)
            XCTAssertNotNil(categories![10].name)
        }

        // Test Central Kurdish azkar categories
        Azkars.azkarCategories(language: .ckb) { categories, error in
            XCTAssertNil(error)
            XCTAssertNotNil(categories)
            XCTAssertEqual(categories!.count, 11)
            XCTAssertNotNil(categories![3].name)
        }

        // Test Farsi azkar categories
        Azkars.azkarCategories(language: .fa) { categories, error in
            XCTAssertNil(error)
            XCTAssertNotNil(categories)
            XCTAssertEqual(categories!.count, 11)
            XCTAssertNotNil(categories![1].name)
        }

        // Test Russian azkar categories
        Azkars.azkarCategories(language: .ru) { categories, error in
            XCTAssertNil(error)
            XCTAssertNotNil(categories)
            XCTAssertEqual(categories!.count, 11)
            XCTAssertNotNil(categories![7].name)
        }
    }
}
