//
//  Azkars.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/13/18.
//

import Foundation

public enum Azkars {
    // MARK: - Public Methods

    /// Get list of azkar categories which is localized by given language.
    ///
    /// - Parameters:
    ///   - language: Language of the azkar categories.
    ///   - callback: Callback that will return list of AzkarCategory object that contains
    ///               azkar category data or error message.
    public static func azkarCategories(language: Language, callback: @escaping ([AzkarCategory]?, String?) -> Void) {
        DBHelper.shared.azkarCategories(language: language) { categories, error in
            guard error == nil else {
                callback(nil, error)
                return
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
    public static func azkarChapters(language: Language,
                                     categoryId: Int? = nil,
                                     callback: @escaping ([AzkarChapter]?, String?) -> Void) {
        DBHelper.shared.azkarChapters(language: language, categoryId: categoryId) { chapters, error in
            guard error == nil else {
                callback(nil, error)
                return
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
    public static func azkarItems(language: Language,
                                  chapterId: Int,
                                  callback: @escaping ([AzkarItem]?, String?) -> Void) {
        DBHelper.shared.azkarItems(language: language, chapterId: chapterId) { items, error in
            guard error == nil else {
                callback(nil, error)
                return
            }

            callback(items, nil)
        }
    }
}
