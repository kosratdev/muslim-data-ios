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

    func testEnNamesOfAllah() async throws {
        try await assesNames(language: .en)
    }

    func testArNamesOfAllah() async throws {
        try await assesNames(language: .ar)
    }

    func testCkbNamesOfAllah() async throws {
        try await assesNames(language: .ckb)
    }

    func testFaNamesOfAllah() async throws {
        try await assesNames(language: .fa)

    }

    func testRuNamesOfAllah() async throws {
        try await assesNames(language: .ru)
    }

    private func assesNames(language: Language) async throws {
        let names = try await MuslimRepository().getNamesOfAllah(language: language)
        XCTAssertNotNil(names)
        XCTAssertEqual(names!.count, 99)
    }
}
