//
//  Repository.swift
//  MuslimData
//
//  Created by Kosrat Ahmed on 20/03/2024.
//

import Foundation

public protocol Repository {
    func searchLocation(locationName: String) async throws -> [Location]?

    func geocoder(countryCode: String, locationName: String) async throws -> Location?

    func reverseGeocoder(latitude: Double, longitude: Double) async throws -> Location?

    func getPrayerTimes(location: Location, date: Date, attributes: PrayerAttribute) async throws -> PrayerTime?

    func getNamesOfAllah(language: Language) async throws -> [Name]?

    func getAzkarCategories(language: Language) async throws -> [AzkarCategory]?

    func getAzkarChapters(language: Language, categoryId: Int) async throws -> [AzkarChapter]?
    
    func getAzkarChapters(language: Language, chapterIds: [Int]) async throws -> [AzkarChapter]?

    func getAzkarItems(chapterId: Int, language: Language) async throws -> [AzkarItem]?
}
