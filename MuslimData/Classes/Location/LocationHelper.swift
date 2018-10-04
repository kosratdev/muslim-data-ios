//
//  LocationHelper.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/3/18.
//

import Foundation

/// Location helper model that holds some helper methods about locations that we may need it in the MuslimData.
struct LocationHelper {
    // MARK: - Properties

    let dbHelper: DBHelper
    public static let shared = LocationHelper()

    // MARK: - Constructor

    private init() {
        dbHelper = DBHelper.shared
    }

    // MARK: - Public Methods

    /// Search for a city in the database
    ///
    /// - Parameters:
    ///   - city: City name
    ///   - callback: Callback that returns a Location object.
    public func citySearch(_ city: String, callback: @escaping ([Location]?, String?) -> Void) {
        DispatchQueue.global().async {
            do {
                try self.dbHelper.dbPool?.read { dbConnect in
                    let result = try Location.fetchAll(dbConnect, "SELECT * FROM cities where city like '%\(city)%'")
                    callback(result, nil)
                }
            } catch {
                callback(nil, "Error: \(error.localizedDescription)")
            }
        }
    }
}
