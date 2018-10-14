//
//  Azkars.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/13/18.
//

import Foundation

public class Azkars {
    // MARK: - Public Methods

    /// Get list of azkar categories which is localized by given language.
    ///
    /// - Parameters:
    ///   - language: Language of the azkar categories.
    ///   - callback: Callback that will return list of AzkarCategory object that contains
    ///               azkar category data or error message.
    public static func azkarCategories(language: Language, callback: @escaping ([AzkarCategory]?, String?) -> Void) {
        DBHelper.shared.azkarCategories(language: language) { rows, error in
            guard error == nil else {
                callback(nil, error)
                return
            }

            var categories: [AzkarCategory] = []
            for row in rows! {
                let name = AzkarCategory(id: row["_id"], name: row["category_name"])
                categories.append(name)
            }
            callback(categories, nil)
        }
    }

    /// Get list of azkar chapters which is localized by given language.
    ///
    /// - Parameters:
    ///   - language: Language of the azkar chapters.
    ///   - callback: Callback that will return list of AzkarChapter object that contains
    ///               azkar chapter data or error message.
    public static func azkarChapters(language: Language, categoryId: Int? = nil,
                                     callback: @escaping ([AzkarChapter]?, String?) -> Void) {
        DBHelper.shared.azkarChapters(language: language, categoryId: categoryId) { rows, error in
            guard error == nil else {
                callback(nil, error)
                return
            }

            var chapters: [AzkarChapter] = []
            for row in rows! {
                let name = AzkarChapter(id: row["_id"], categoryId: row["category_id"], name: row["chapter_name"])
                chapters.append(name)
            }
            callback(chapters, nil)
        }
    }

    /// Get azkar items for specific azkar chapter from database which is localized by given language.
    ///
    /// - Parameters:
    ///   - language: Language of the chapter.
    ///   - chapterId: Chapter id for the azkar items.
    ///   - callback: Callback that will return list of AzkarItem object that contains azkar items data
    ///               or error message.
    public static func azkarItems(language: Language, chapterId: Int,
                                  callback: @escaping ([AzkarItem]?, String?) -> Void) {
        DBHelper.shared.azkarItems(language: language, chapterId: chapterId) { rows, error in
            guard error == nil else {
                callback(nil, error)
                return
            }

            var items: [AzkarItem] = []
            for row in rows! {
                let name = AzkarItem(id: row["_id"], chapterId: row["chapter_id"], item: row["item"],
                                     translation: "item_translation", reference: "reference")
                items.append(name)
            }
            callback(items, nil)
        }
    }
}
