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
}
