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
        let databaseURL = Bundle(for: DBHelper.self).path(forResource: "MuslimData", ofType: "db")!
        dbPool = try? DatabasePool(path: databaseURL)

        // Be a nice iOS citizen, and don’t consume too much memory
        // See https://github.com/groue/GRDB.swift/#memory-management
        dbPool?.setupMemoryManagement(in: UIApplication.shared)
    }

    // MARK: - Public Methods

    func prayerTimes(countryCode: String, city: String, date: Date, callback: @escaping (Row?, String?) -> Void) {
        do {
            try dbPool?.read { dbConnect in
                let result = try Row.fetchOne(dbConnect, """
                SELECT * FROM prayer_times
                WHERE country_code = '\(countryCode)' and city = '\(city.mapper(countryCode: countryCode))'
                and date = '\(formatPrayerDate(date))'
                """)
                guard let row = result else {
                    callback(nil, "Found nil while unwrapping result.")
                    return
                }
                callback(row, nil)
            }
        } catch {
            callback(nil, "Error: \(error.localizedDescription)")
        }
    }

    /// Get 99 names of allah from database.
    ///
    /// - Parameters:
    ///   - language: Language of the translated names.
    ///   - callback: Callback that will return list of names object or error message.
    func names(language: Language, callback: @escaping ([Name]?, String?) -> Void) {
        do {
            try dbPool?.read { dbConnect in
                let result = try Name.fetchAll(dbConnect, """
                SELECT ori.name , tr.name as translated
                FROM names as ori
                INNER JOIN names_translations as tr on tr.name_id = ori._id and tr.language = '\(language)'
                """)
                guard result.count > 0 else {
                    callback(nil, "No row found")
                    return
                }
                callback(result, nil)
            }
        } catch {
            callback(nil, "Error: \(error.localizedDescription)")
        }
    }

    /// Get azkar categories from database which is localized by given language.
    ///
    /// - Parameters:
    ///   - language: Language of the category.
    ///   - callback: Callback that will return list of Row object that contains azkar category data or error message.
    func azkarCategories(language: Language, callback: @escaping ([Row]?, String?) -> Void) {
        do {
            try dbPool?.read { dbConnect in
                let result = try Row.fetchAll(dbConnect, """
                SELECT org._id, category_name
                FROM azkar_categories as org
                INNER JOIN azkar_categories_translations as tr on tr.category_id = org._id
                and language = '\(language)'
                """)
                guard result.count > 0 else {
                    callback(nil, "No row found")
                    return
                }
                callback(result, nil)
            }
        } catch {
            callback(nil, "Error: \(error.localizedDescription)")
        }
    }

    /// Get azkar chapters from database which is localized by given language.
    ///
    /// - Parameters:
    ///   - language: Language of the chapter.
    ///   - callback: Callback that will return list of Row object that contains azkar chapters data or error message.
    func azkarChapters(language: Language, categoryId: Int? = nil, callback: @escaping ([Row]?, String?) -> Void) {
        var category = ""
        if let categoryId = categoryId {
            category = " and category_id = \(categoryId)"
        }
        do {
            try dbPool?.read { dbConnect in
                let result = try Row.fetchAll(dbConnect, """
                SELECT org._id, category_id, chapter_name
                FROM azkar_chapters as org
                INNER JOIN azkar_chapters_translations as tr on tr.chapter_id = org._id and language = '\(language)'
                \(category)
                """)
                guard result.count > 0 else {
                    callback(nil, "No row found")
                    return
                }
                callback(result, nil)
            }
        } catch {
            callback(nil, "Error: \(error.localizedDescription)")
        }
    }

    /// Get azkar items for specific azkar chapter from database which is localized by given language.
    ///
    /// - Parameters:
    ///   - language: Language of the chapter.
    ///   - chapterId: Chapter id for the azkar items.
    ///   - callback: Callback that will return list of Row object that contains azkar items data or error message.
    func azkarItems(language: Language, chapterId: Int, callback: @escaping ([Row]?, String?) -> Void) {
        do {
            try dbPool?.read { dbConnect in
                let result = try Row.fetchAll(dbConnect, """
                SELECT org._id, org.chapter_id, org.item, tr.item_translation, rtr.reference
                FROM azkar_items as org
                INNER JOIN azkar_items_translations as tr on tr.item_id = org._id and tr.language = '\(language)'
                and org.chapter_id = \(chapterId)
                INNER JOIN azkar_references as ref on ref.item_id = org._id
                INNER JOIN azkar_references_translations as rtr on rtr.reference_id = ref._id
                and rtr.language = '\(language)'
                """)
                guard result.count > 0 else {
                    callback(nil, "No row found")
                    return
                }
                callback(result, nil)
            }
        } catch {
            callback(nil, "Error: \(error.localizedDescription)")
        }
    }

    // MARK: - Private Methods

    /// Format date to "MM-dd" pattern which will be used to get prayers fro this date in the prayer database.
    ///
    /// - Parameter date: Date instance.
    /// - Returns: Formatted date by "MM-dd" pattern.
    private func formatPrayerDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "us")
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: date)
    }
}
