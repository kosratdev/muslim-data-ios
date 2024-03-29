//
//  DBHelper.swift
//  GRDB.swift
//
//  Created by Kosrat D. Ahmad on 9/27/18.
//

import GRDB
import UIKit

class DBHelper {
    // MARK: - Properties

    var dbPool: DatabasePool?
    static let shared = DBHelper()

    // MARK: - Life cycle

    private init() {
        var configuration = Configuration()
        configuration.readonly = true
        let databaseURL = Bundle(for: DBHelper.self).path(forResource: "muslim_db_v2.0.0", ofType: "db")!
        dbPool = try? DatabasePool(path: databaseURL, configuration: configuration)

        // Be a nice iOS citizen, and don’t consume too much memory
        // See https://github.com/groue/GRDB.swift/#memory-management
        dbPool?.setupMemoryManagement(in: UIApplication.shared)
    }

    // MARK: - Public Methods

    /// Get fixed prayer times from Muslim database.
    /// - Parameters:
    ///   - location: Location object
    ///   - date: Prayer date
    /// - Returns: PrayerTime instance.
    func prayerTimes(location: Location, date: Date) async throws -> PrayerTime? {
        do {
            return try dbPool?.read { dbConnect in
                let result = try Row.fetchOne(dbConnect, sql: """
                SELECT * FROM prayer_time
                WHERE location_id = '\(location.prayerDependentId ?? location.id)'
                and date = '\(date.toDBDate())'
                """)

                guard let row = result else {
                    print("Found nil while unwrapping result.")
                    return nil
                }

                // Getting data from columns
                guard let fajr = row["fajr"] as? String,
                      let sunrise = row["sunrise"] as? String,
                      let dhuhr = row["dhuhr"] as? String,
                      let asr = row["asr"] as? String,
                      let maghrib = row["maghrib"] as? String,
                      let isha = row["isha"] as? String
                else {
                    print("All columns are not found in the row.")
                    return nil
                }

                // Create PrayerTime object.
                return PrayerTime(fajr: fajr.toDate(date),
                                  sunrise: sunrise.toDate(date),
                                  dhuhr: dhuhr.toDate(date),
                                  asr: asr.toDate(date),
                                  maghrib: maghrib.toDate(date),
                                  isha: isha.toDate(date))
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    /// Get 99 names of Allah from database for the given language.
    ///
    /// - Parameters:
    ///   - language: Language of the translated names.
    /// - Returns: List of [name]? of Allah
    func names(language: Language) async throws -> [Name]? {
        do {
            return try dbPool?.read { dbConnect in
                let names = try Name.fetchAll(dbConnect, sql: """
                SELECT name.name , transl.name as translated
                FROM name
                INNER JOIN name_translation as transl on transl.name_id = name._id and transl.language = '\(language)'
                """)
                return names
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    /// Get azkar categories from database which is localized by the given language.
    ///
    /// - Parameters:
    ///   - language: Language of the category.
    /// - Returns: List of [AzkarCategory]?
    func azkarCategories(language: Language) async throws -> [AzkarCategory]? {
        do {
            return try dbPool?.read { dbConnect in
                let categories = try AzkarCategory.fetchAll(dbConnect, sql: """
                SELECT category._id, category_name
                FROM azkar_category as category
                INNER JOIN azkar_category_translation as transl on transl.category_id = category._id
                and language = '\(language)'
                """)
                return categories
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    /// Get azkar chapters from database which is localized by given language.
    /// 
    /// - Parameters:
    ///   - language: Language of the chapter.
    ///   - categoryId: Optional category id
    /// - Returns: List of [AzkarChapter]?
    func azkarChapters(language: Language, categoryId: Int? = nil) async throws -> [AzkarChapter]? {
        var category = ""
        if let categoryId = categoryId {
            category = " and category_id = \(categoryId)"
        }
        do {
            return try dbPool?.read { dbConnect in
                let chapters = try AzkarChapter.fetchAll(dbConnect, sql: """
                SELECT chapter._id, category_id, chapter_name
                FROM azkar_chapter as chapter
                INNER JOIN azkar_chapter_translation as transl on transl.chapter_id = chapter._id
                and language = '\(language)' \(category)
                """)
                return chapters
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    /// Get azkar items for specific azkar chapter from database which is localized by given language.
    /// 
    /// - Parameters:
    ///   - language: Language of the chapter.
    ///   - chapterId: Chapter id for the azkar items.
    /// - Returns: List of [AskarItem]?
    func azkarItems(language: Language, chapterId: Int) async throws -> [AzkarItem]? {
        do {
            return try dbPool?.read { dbConnect in
                let items = try AzkarItem.fetchAll(dbConnect, sql: """
                SELECT item._id, item.chapter_id, item.item, transl.item_translation, ref_transl.reference
                FROM azkar_item as item
                INNER JOIN azkar_item_translation as transl on transl.item_id = item._id
                and transl.language = '\(language)' and item.chapter_id = \(chapterId)
                INNER JOIN azkar_reference as ref on ref.item_id = item._id
                INNER JOIN azkar_reference_translation as ref_transl on ref_transl.reference_id = ref._id
                and ref_transl.language = '\(language)'
                """)
                return items
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    /// Search for a location in the database
    ///
    /// - Parameters:
    ///   - locationName: location name
    ///   - callback: Callback that returns a Location object.
    /// - Returns: List of found locations
    public func searchLocation(_ locationName: String) async throws -> [Location]? {
            do {
                return try dbPool?.read { dbConnect in
                    let locations = try Location.fetchAll(dbConnect, sql: """
                    SELECT location._id as _id, country.code as country_code, country.name as country_name,
                           location.name as name, latitude, longitude, has_fixed_prayer_time, prayer_dependent_id
                    FROM location
                    INNER JOIN country on country._id = location.country_id
                    WHERE location.name like '\(locationName)%'
                    """)
                    return locations
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                return nil
            }
    }

    /// Geocoder to find location by it's name.
    /// 
    /// - Parameters:
    ///   - countryCode: Country code
    ///   - locationName: location name
    /// - Returns: geocoded location
    public func geocoder(countryCode: String, locationName: String) async throws -> Location? {
        do {
            return try dbPool?.read { dbConnect in
                let location = try Location.fetchOne(dbConnect, sql: """
                SELECT location._id as _id, country.code as country_code, country.name as country_name,
                       location.name as name, latitude, longitude, has_fixed_prayer_time, prayer_dependent_id
                FROM location
                INNER JOIN country on country._id = location.country_id
                WHERE country.code = '\(countryCode)' COLLATE NOCASE
                and location.name = '\(locationName)' COLLATE NOCASE
                """)
                return location
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    /// Reverse geocoder to find location by it's latitude and longitude.
    /// 
    /// - Parameters:
    ///   - latitude: Location latitude.
    ///   - longitude: Location longitude.
    /// - Returns: reverse geocoded location
    public func reverseGeocoder(latitude: Double, longitude: Double) async throws -> Location? {
        do {
            return try dbPool?.read { dbConnect in
                let location = try Location.fetchOne(dbConnect, sql: """
                SELECT location._id as _id, country.code as country_code, country.name as country_name,
                       location.name as name, latitude, longitude, has_fixed_prayer_time, prayer_dependent_id
                FROM location
                INNER JOIN country on country._id = location.country_id
                ORDER BY abs(latitude - (\(latitude))) + abs(longitude - (\(longitude)))
                LIMIT 1
                """)
                return location
            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }

    /// Get all the locations that has fixed prayer times.
    /// - Returns: Location list
    public func fixedPrayerTimesList() -> [Location]? {
        do {
            return try dbPool?.read { dbConnect in
                let locations = try Location.fetchAll(dbConnect, sql: """
                SELECT location._id as _id, country.code as country_code, country.name as country_name,
                       location.name as name, latitude, longitude, has_fixed_prayer_time, prayer_dependent_id
                FROM location
                INNER JOIN country on country._id = location.country_id
                WHERE has_fixed_prayer_time=1
                """)
               return locations
            }
        } catch {
            return nil
        }
    }
}
