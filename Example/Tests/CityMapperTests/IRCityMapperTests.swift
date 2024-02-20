//
//  IRCityMapperTests.swift
//  MuslimData_Tests
//
//  Created by Kosrat Ahmed on 19/02/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
@testable import MuslimData

class IRCityMapperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testSanandajCityMapper() {
        XCTAssertEqual("Kamyaran".mapper(countryCode: "IR"), "Sanandaj")
        XCTAssertEqual("Divandarreh".mapper(countryCode: "IR"), "Sanandaj")
        XCTAssertEqual("Dehgolan".mapper(countryCode: "IR"), "Sanandaj")
        XCTAssertEqual("Qorveh".mapper(countryCode: "IR"), "Sanandaj")
    }
    
    func testUrmiaCityMapper() {
        XCTAssertEqual("Orumiyeh".mapper(countryCode: "IR"), "Urmia")
    }
}
