//
//  File.swift
//  
//
//  Created by Kosrat Ahmed on 24/03/2024.
//

@testable import MuslimData
import XCTest

class AzkarChapterTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEnAzkarChapters() async throws {
        try await assesAzkarChapters(language: .en)
    }

    func testArAzkarChapters() async throws {
        try await assesAzkarChapters(language: .ar)
    }

    func testCkbAzkarChapters() async throws {
        try await assesAzkarChapters(language: .ckb)
    }

    func testFaAzkarChapters() async throws {
        try await assesAzkarChapters(language: .fa)
    }

    func testRuAzkarChapters() async throws {
        try await assesAzkarChapters(language: .ru)
    }

    private func assesAzkarChapters(language: Language, categoryId: Int = -1, total: Int = 133) async throws {
        let chapters = try await MuslimRepository().getAzkarChapters(language: language, categoryId: categoryId)
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, total)
    }
    
    func testAzkarChaptersByChapterIds() async throws {
        let chapters = try await MuslimRepository().getAzkarChapters(language: .en, chapterIds: Array(1...133))
        XCTAssertNotNil(chapters)
        XCTAssertEqual(chapters!.count, 133)
    }

    func testEnAzkarChaptersByCategory() async throws {
        try await assesAzkarChapters(language: .en, categoryId: 1, total: 7)
        try await assesAzkarChapters(language: .en, categoryId: 2, total: 14)
        try await assesAzkarChapters(language: .en, categoryId: 3, total: 7)
        try await assesAzkarChapters(language: .en, categoryId: 4, total: 15)
        try await assesAzkarChapters(language: .en, categoryId: 5, total: 11)
        try await assesAzkarChapters(language: .en, categoryId: 6, total: 19)
        try await assesAzkarChapters(language: .en, categoryId: 7, total: 9)
        try await assesAzkarChapters(language: .en, categoryId: 8, total: 8)
        try await assesAzkarChapters(language: .en, categoryId: 9, total: 20)
        try await assesAzkarChapters(language: .en, categoryId: 10, total: 10)
        try await assesAzkarChapters(language: .en, categoryId: 11, total: 13)
    }

    func testArAzkarChaptersByCategory() async throws {
        try await assesAzkarChapters(language: .ar, categoryId: 1, total: 7)
        try await assesAzkarChapters(language: .ar, categoryId: 2, total: 14)
        try await assesAzkarChapters(language: .ar, categoryId: 3, total: 7)
        try await assesAzkarChapters(language: .ar, categoryId: 4, total: 15)
        try await assesAzkarChapters(language: .ar, categoryId: 5, total: 11)
        try await assesAzkarChapters(language: .ar, categoryId: 6, total: 19)
        try await assesAzkarChapters(language: .ar, categoryId: 7, total: 9)
        try await assesAzkarChapters(language: .ar, categoryId: 8, total: 8)
        try await assesAzkarChapters(language: .ar, categoryId: 9, total: 20)
        try await assesAzkarChapters(language: .ar, categoryId: 10, total: 10)
        try await assesAzkarChapters(language: .ar, categoryId: 11, total: 13)
    }

    func testCkbAzkarChaptersByCategory() async throws {
        try await assesAzkarChapters(language: .ckb, categoryId: 1, total: 7)
        try await assesAzkarChapters(language: .ckb, categoryId: 2, total: 14)
        try await assesAzkarChapters(language: .ckb, categoryId: 3, total: 7)
        try await assesAzkarChapters(language: .ckb, categoryId: 4, total: 15)
        try await assesAzkarChapters(language: .ckb, categoryId: 5, total: 11)
        try await assesAzkarChapters(language: .ckb, categoryId: 6, total: 19)
        try await assesAzkarChapters(language: .ckb, categoryId: 7, total: 9)
        try await assesAzkarChapters(language: .ckb, categoryId: 8, total: 8)
        try await assesAzkarChapters(language: .ckb, categoryId: 9, total: 20)
        try await assesAzkarChapters(language: .ckb, categoryId: 10, total: 10)
        try await assesAzkarChapters(language: .ckb, categoryId: 11, total: 13)
    }

    func testFaAzkarChaptersByCategory() async throws {
        try await assesAzkarChapters(language: .fa, categoryId: 1, total: 7)
        try await assesAzkarChapters(language: .fa, categoryId: 2, total: 14)
        try await assesAzkarChapters(language: .fa, categoryId: 3, total: 7)
        try await assesAzkarChapters(language: .fa, categoryId: 4, total: 15)
        try await assesAzkarChapters(language: .fa, categoryId: 5, total: 11)
        try await assesAzkarChapters(language: .fa, categoryId: 6, total: 19)
        try await assesAzkarChapters(language: .fa, categoryId: 7, total: 9)
        try await assesAzkarChapters(language: .fa, categoryId: 8, total: 8)
        try await assesAzkarChapters(language: .fa, categoryId: 9, total: 20)
        try await assesAzkarChapters(language: .fa, categoryId: 10, total: 10)
        try await assesAzkarChapters(language: .fa, categoryId: 11, total: 13)
    }

    func testRuAzkarChaptersByCategory() async throws {
        try await assesAzkarChapters(language: .ru, categoryId: 1, total: 7)
        try await assesAzkarChapters(language: .ru, categoryId: 2, total: 14)
        try await assesAzkarChapters(language: .ru, categoryId: 3, total: 7)
        try await assesAzkarChapters(language: .ru, categoryId: 4, total: 15)
        try await assesAzkarChapters(language: .ru, categoryId: 5, total: 11)
        try await assesAzkarChapters(language: .ru, categoryId: 6, total: 19)
        try await assesAzkarChapters(language: .ru, categoryId: 7, total: 9)
        try await assesAzkarChapters(language: .ru, categoryId: 8, total: 8)
        try await assesAzkarChapters(language: .ru, categoryId: 9, total: 20)
        try await assesAzkarChapters(language: .ru, categoryId: 10, total: 10)
        try await assesAzkarChapters(language: .ru, categoryId: 11, total: 13)
    }
}
