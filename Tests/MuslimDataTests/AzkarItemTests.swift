//
//  AzkarTests.swift
//  MuslimData_Tests
//
//  Created by Kosrat D. Ahmad on 10/13/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

@testable import MuslimData
import XCTest

class AzkarItemTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEnAzkarItems() async throws {
        try await assesAzkarItems(language: .en, id: 1, total: 4)
    }

    func testArAzkarItems() async throws {
        try await assesAzkarItems(language: .ar, id: 25, total: 8)
    }

    func testCkbAzkarItems() async throws {
        try await assesAzkarItems(language: .ckb, id: 50, total: 2)
    }

    func testFaAzkarItems() async throws {
        try await assesAzkarItems(language: .fa, id: 75, total: 1)
    }

    func testRuAzkarItems() async throws {
        try await assesAzkarItems(language: .ru, id: 100, total: 1)
    }

    func assesAzkarItems(language: Language, id: Int, total: Int) async throws {
        let items = try await MuslimRepository().getAzkarItems(chapterId: id, language: language)
        XCTAssertNotNil(items)
        XCTAssertEqual(items!.count, total)
    }
}
