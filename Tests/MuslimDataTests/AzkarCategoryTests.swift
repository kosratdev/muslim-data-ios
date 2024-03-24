//
//  File.swift
//  
//
//  Created by Kosrat Ahmed on 24/03/2024.
//

@testable import MuslimData
import XCTest

class AzkarCategoryTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEnAzkarCategories() async throws {
        try await assesAzkarCategories(language: .en)
    }

    func testArAzkarCategories() async throws {
        try await assesAzkarCategories(language: .ar)
    }

    func testCkbAzkarCategories() async throws {
        try await assesAzkarCategories(language: .ckb)
    }

    func testFaAzkarCategories() async throws {
        try await assesAzkarCategories(language: .fa)
    }

    func testRuAzkarCategories() async throws {
        try await assesAzkarCategories(language: .ru)
    }

    private func assesAzkarCategories(language: Language) async throws {
        let categories = try await MuslimRepository().getAzkarCategories(language: language)
        XCTAssertNotNil(categories)
        XCTAssertEqual(categories!.count, 11)
        XCTAssertNotNil(categories![Int.random(in: 0 ..< 11)].name)
    }
}
