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

    func testEnglishNames() async throws {
        let names = try await MuslimRepository().getNamesOfAllah(language: .en)
        assesNames(names: names)
    }

    func testArabicNames() async throws {
        let names = try await MuslimRepository().getNamesOfAllah(language: .ar)
        assesNames(names: names)
    }

    func testKurdishNames() async throws {
        let names = try await MuslimRepository().getNamesOfAllah(language: .ckb)
        assesNames(names: names)
    }

    func testFarsiNames() async throws {
        let names = try await MuslimRepository().getNamesOfAllah(language: .fa)
        assesNames(names: names)
    }

    func testRussianNames() async throws {
        let names = try await MuslimRepository().getNamesOfAllah(language: .ru)
        assesNames(names: names)
    }

    private func assesNames(names: [Name]?) {
        XCTAssertNotNil(names)
        XCTAssertEqual(names!.count, 99)
    }
}
