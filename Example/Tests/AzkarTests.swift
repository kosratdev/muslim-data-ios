//
//  AzkarTests.swift
//  MuslimData_Tests
//
//  Created by Kosrat D. Ahmad on 10/13/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

@testable import MuslimData
import XCTest

class AzkarTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEnAzkarCategories() async throws {
        let categories = try await MuslimRepository().getAzkarCategories(language: .en)
        assesAzkarCategories(categories: categories)
    }

    func testArAzkarCategories() async throws {
        let categories = try await MuslimRepository().getAzkarCategories(language: .ar)
        assesAzkarCategories(categories: categories)
    }

    func testCkbAzkarCategories() async throws {
        let categories = try await MuslimRepository().getAzkarCategories(language: .ckb)
        assesAzkarCategories(categories: categories)
    }

    func testFaAzkarCategories() async throws {
        let categories = try await MuslimRepository().getAzkarCategories(language: .fa)
        assesAzkarCategories(categories: categories)
    }

    func testRuAzkarCategories() async throws {
        let categories = try await MuslimRepository().getAzkarCategories(language: .ru)
        assesAzkarCategories(categories: categories)
    }

    private func assesAzkarCategories(categories: [AzkarCategory]?) {
        XCTAssertNotNil(categories)
        XCTAssertEqual(categories!.count, 11)
        XCTAssertNotNil(categories![Int.random(in: 0 ..< 11)].name)
    }

    func testEnAzkarChapters() async throws {
        let chapters = try await MuslimRepository().getAzkarChapters(language: .en)
        assesAzkarChapters(chapters: chapters)
    }

    func testArAzkarChapters() async throws {
        let chapters = try await MuslimRepository().getAzkarChapters(language: .ar)
        assesAzkarChapters(chapters: chapters)
    }

    func testCkbAzkarChapters() async throws {
        let chapters = try await MuslimRepository().getAzkarChapters(language: .ckb)
        assesAzkarChapters(chapters: chapters)
    }

    func testFaAzkarChapters() async throws {
        let chapters = try await MuslimRepository().getAzkarChapters(language: .fa)
        assesAzkarChapters(chapters: chapters)
    }

    func testRuAzkarChapters() async throws {
        let chapters = try await MuslimRepository().getAzkarChapters(language: .ru)
        assesAzkarChapters(chapters: chapters)
    }

    private func assesAzkarChapters(chapters: [AzkarChapter]?) {
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 133)
    }

    func testAzkarChaptersByCategory() async throws {
        // Test English azkar chapters for category id = 1
        var chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 1)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 7)

        // Test English azkar chapters for category id = 2
        chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 2)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 14)

        // Test English azkar chapters for category id = 3
        chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 3)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 7)

        // Test English azkar chapters for category id = 4
        chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 4)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 15)

        // Test English azkar chapters for category id = 5
        chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 5)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 11)

        // Test English azkar chapters for category id = 6
        chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 6)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 19)

        // Test English azkar chapters for category id = 7
        chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 7)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 9)

        // Test English azkar chapters for category id = 8
        chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 8)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 8)

        // Test English azkar chapters for category id = 9
        chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 9)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 20)

        // Test English azkar chapters for category id = 10
        chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 10)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 10)

        // Test English azkar chapters for category id = 11
        chapters = try await MuslimRepository().getAzkarChapters(language: .en, categoryId: 11)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 13)
    }

    func testAzkarItems() async throws {
        // Test English azkar items for chapter id = 1
        var items = try await MuslimRepository().getAzkarItems(language: .en, chapterId: 1)
        XCTAssertNotNil(items)
        XCTAssertEqual(items!.count, 4)

        // Test English azkar items for chapter id = 10
        items = try await MuslimRepository().getAzkarItems(language: .en, chapterId: 10)
        XCTAssertNotNil(items)
        XCTAssertEqual(items!.count, 2)

        // Test English azkar items for chapter id = 100
        items = try await MuslimRepository().getAzkarItems(language: .en, chapterId: 100)
        XCTAssertNotNil(items)
        XCTAssertEqual(items!.count, 1)
    }
}
