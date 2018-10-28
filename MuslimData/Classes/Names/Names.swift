//
//  Names.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/11/18.
//

import Foundation

/// Names class that has a helper method to return a list of Names.
public class Names {
    // MARK: - Public Methods

    /// Get list of names of allah with translation for given language.
    ///
    /// - Parameters:
    ///   - language: Language for translating names.
    ///   - callback: Callback that return list of names or an error message
    public static func names(language: Language, callback: @escaping ([Name]?, String?) -> Void) {
        DBHelper.shared.names(language: language) { names, error in
            guard error == nil else {
                callback(nil, error)
                return
            }

            callback(names, nil)
        }
    }
}
