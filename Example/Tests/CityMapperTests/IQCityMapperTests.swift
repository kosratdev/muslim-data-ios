//
//  IQCityMapperTests.swift
//  MuslimData_Tests
//
//  Created by Kosrat Ahmed on 19/02/2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
@testable import MuslimData

class IQCityMapperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDuhokCityMapper() {
        XCTAssertEqual("Sumel".mapper(countryCode: "IQ"), "Duhok")
        XCTAssertEqual("Zawita".mapper(countryCode: "IQ"), "Duhok")
        XCTAssertEqual("Atrish".mapper(countryCode: "IQ"), "Duhok")
        XCTAssertEqual("Sharya".mapper(countryCode: "IQ"), "Duhok")
        XCTAssertEqual("Mrebah".mapper(countryCode: "IQ"), "Duhok")
    }
    
    func testAkreCityMapper() {
        XCTAssertEqual("Amedi".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Sulav".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Kani".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Sheladiz".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Barzan".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Bele".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Shanidar".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Bujal".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Mergin".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Susna".mapper(countryCode: "IQ"), "Akre")
        XCTAssertEqual("Sersink".mapper(countryCode: "IQ"), "Akre")
    }
    
    func testBardarashCityMapper() {
        XCTAssertEqual("Mamuzin".mapper(countryCode: "IQ"), "Bardarash")
    }
    
    func testErbilCityMapper() {
        XCTAssertEqual("Kalak".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Pirmam".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Shaqlawa".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Harir".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Khalifan".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Rawanduz".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Soran".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Mergasur".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Galala".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Choman".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Hiran".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Qushtapa".mapper(countryCode: "IQ"), "Erbil")
        XCTAssertEqual("Kasnazan".mapper(countryCode: "IQ"), "Erbil")
    }
    
    func testQasreCityMapper() {
        XCTAssertEqual("Wallze".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Soraban".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Shnawa".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Rashdur".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Makosan".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Saya".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Walash".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Eskawa".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Xazena".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Dilman".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Sarkan".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Chomsak".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Qalat".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Koila".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Mawnan".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Wasan".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Choma".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Mergay Khwaru".mapper(countryCode: "IQ"), "Qasre")
        XCTAssertEqual("Kani bast".mapper(countryCode: "IQ"), "Qasre")
    }
    
    func testKirkukCityMapper() {
        XCTAssertEqual("Taza Khurmatu".mapper(countryCode: "IQ"), "Kirkuk")
    }
    
    func testSulaymaniyahCityMapper() {
        XCTAssertEqual("Mawat".mapper(countryCode: "IQ"), "Sulaymaniyah")
        XCTAssertEqual("Arbat".mapper(countryCode: "IQ"), "Sulaymaniyah")
    }
    
    func testQaladizaCityMapper() {
        XCTAssertEqual("Halsho".mapper(countryCode: "IQ"), "Qaladiza")
        XCTAssertEqual("Nawdasht".mapper(countryCode: "IQ"), "Qaladiza")
        XCTAssertEqual("Tasluja".mapper(countryCode: "IQ"), "Qaladiza")
        XCTAssertEqual("Bazian".mapper(countryCode: "IQ"), "Qaladiza")
        XCTAssertEqual("Sangasar".mapper(countryCode: "IQ"), "Qaladiza")
        XCTAssertEqual("Zharawa".mapper(countryCode: "IQ"), "Qaladiza")
        XCTAssertEqual("Bngrd".mapper(countryCode: "IQ"), "Qaladiza")
        XCTAssertEqual("Hero".mapper(countryCode: "IQ"), "Qaladiza")
    }
    
    func testDokanCityMapper() {
        XCTAssertEqual("Piramagroon".mapper(countryCode: "IQ"), "Dokan")
    }
    
    func testRanyaCityMapper() {
        XCTAssertEqual("Hajiawa".mapper(countryCode: "IQ"), "Ranya")
        XCTAssertEqual("Sarkapkan".mapper(countryCode: "IQ"), "Ranya")
        XCTAssertEqual("Khalakan".mapper(countryCode: "IQ"), "Ranya")
        XCTAssertEqual("Taqtaq".mapper(countryCode: "IQ"), "Ranya")
        XCTAssertEqual("Hizop".mapper(countryCode: "IQ"), "Ranya")
        XCTAssertEqual("Chwarqurna".mapper(countryCode: "IQ"), "Ranya")
    }
    
    func testChamchamalCityMapper() {
        XCTAssertEqual("Takiya".mapper(countryCode: "IQ"), "Chamchamal")
        XCTAssertEqual("Takiay Jabari".mapper(countryCode: "IQ"), "Chamchamal")
        XCTAssertEqual("Shorsh".mapper(countryCode: "IQ"), "Chamchamal")
        XCTAssertEqual("Aghjalar".mapper(countryCode: "IQ"), "Chamchamal")
        XCTAssertEqual("Sangaw".mapper(countryCode: "IQ"), "Chamchamal")
    }
    
    func testDarbandikhanCityMapper() {
        XCTAssertEqual("Zalan".mapper(countryCode: "IQ"), "Darbandikhan")
        XCTAssertEqual("Gapilon".mapper(countryCode: "IQ"), "Darbandikhan")
        XCTAssertEqual("Chwarta".mapper(countryCode: "IQ"), "Darbandikhan")
        XCTAssertEqual("Barzinjah".mapper(countryCode: "IQ"), "Darbandikhan")
        XCTAssertEqual("Zarayan".mapper(countryCode: "IQ"), "Darbandikhan")
        XCTAssertEqual("Halebjai Taza".mapper(countryCode: "IQ"), "Darbandikhan")
        XCTAssertEqual("Qara Dagh".mapper(countryCode: "IQ"), "Darbandikhan")
    }
    
    func testPenjwenCityMapper() {
        XCTAssertEqual("Garmk".mapper(countryCode: "IQ"), "Penjwen")
        XCTAssertEqual("Nalparez".mapper(countryCode: "IQ"), "Penjwen")
        XCTAssertEqual("Said Sadiq".mapper(countryCode: "IQ"), "Penjwen")
        XCTAssertEqual("Pshta".mapper(countryCode: "IQ"), "Penjwen")
    }
    
    func testHalabjaCityMapper() {
        XCTAssertEqual("Sirwan".mapper(countryCode: "IQ"), "Halabja")
        XCTAssertEqual("Byara".mapper(countryCode: "IQ"), "Halabja")
        XCTAssertEqual("Tawella".mapper(countryCode: "IQ"), "Halabja")
        XCTAssertEqual("Balkha".mapper(countryCode: "IQ"), "Halabja")
        XCTAssertEqual("Khurmal".mapper(countryCode: "IQ"), "Halabja")
    }
}
