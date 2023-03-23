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

    func testAzkarChapters() {
        // Test English azkar chapters
        Azkars.azkarChapters(language: .en) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 133)
        }

        // Test Arabic azkar chapters
        Azkars.azkarChapters(language: .ar) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 133)
        }

        // Test Central Kurdish azkar chapters
        Azkars.azkarChapters(language: .ckb) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 133)
        }

        // Test Farsi azkar chapters
        Azkars.azkarChapters(language: .fa) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 133)
        }

        // Test Russian azkar chapters
        Azkars.azkarChapters(language: .ru) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 133)
        }
    }

    func testAzkarChaptersByCategory() {
        // Test English azkar chapters for category id = 1
        Azkars.azkarChapters(language: .en, categoryId: 1) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 7)
        }

        // Test English azkar chapters for category id = 2
        Azkars.azkarChapters(language: .en, categoryId: 2) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 14)
        }

        // Test English azkar chapters for category id = 3
        Azkars.azkarChapters(language: .en, categoryId: 3) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 7)
        }

        // Test English azkar chapters for category id = 4
        Azkars.azkarChapters(language: .en, categoryId: 4) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 15)
        }

        // Test English azkar chapters for category id = 5
        Azkars.azkarChapters(language: .en, categoryId: 5) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 11)
        }

        // Test English azkar chapters for category id = 6
        Azkars.azkarChapters(language: .en, categoryId: 6) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 19)
        }

        // Test English azkar chapters for category id = 7
        Azkars.azkarChapters(language: .en, categoryId: 7) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 9)
        }

        // Test English azkar chapters for category id = 8
        Azkars.azkarChapters(language: .en, categoryId: 8) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 8)
        }

        // Test English azkar chapters for category id = 9
        Azkars.azkarChapters(language: .en, categoryId: 9) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 20)
        }

        // Test English azkar chapters for category id = 10
        Azkars.azkarChapters(language: .en, categoryId: 10) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 10)
        }

        // Test English azkar chapters for category id = 11
        Azkars.azkarChapters(language: .en, categoryId: 11) { chapters, error in
            XCTAssertNil(error)
            XCTAssertNotNil(chapters)
            XCTAssertEqual(chapters!.count, 13)
        }
    }

    func testAzkarItems() {
        // Test English azkar items for chapter id = 1
        Azkars.azkarItems(language: .en, chapterId: 1) { items, error in
            XCTAssertNil(error)
            XCTAssertNotNil(items)
            XCTAssertEqual(items!.count, 4)
        }

        // Test English azkar items for chapter id = 10
        Azkars.azkarItems(language: .en, chapterId: 10) { items, error in
            XCTAssertNil(error)
            XCTAssertNotNil(items)
            XCTAssertEqual(items!.count, 2)
        }

        // Test English azkar items for chapter id = 100
        Azkars.azkarItems(language: .en, chapterId: 100) { items, error in
            XCTAssertNil(error)
            XCTAssertNotNil(items)
            XCTAssertEqual(items!.count, 1)
        }
    }
}
