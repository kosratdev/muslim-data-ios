//
//  LocationHelper.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/3/18.
//

import Foundation

/// Location helper model that holds some helper methods about locations that we may need it in the MuslimData.
public struct LocationHelper {
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
        DispatchQueue.global(qos: .background).async {
            do {
                try self.dbHelper.dbPool?.read { dbConnect in
                    let locations = try Location.fetchAll(dbConnect, sql: """
                    SELECT city.country_code as country_code, country_name, city_name,
                           latitude, longitude, has_fixed_prayer_time
                    FROM city
                    INNER JOIN country on city.country_code = country.country_code
                    WHERE city.city_name like '\(city)%'
                    """)
                    DispatchQueue.main.async {
                        callback(locations, nil)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    callback(nil, "Error: \(error.localizedDescription)")
                }
            }
        }
    }

    /// Geocoder to find city location by it's name.
    ///
    /// - Parameters:
    ///   - countryCode: Country code
    ///   - city: City name
    ///   - callback: Callback that returns a Location object.
    public func geocoder(countryCode: String, city: String, callback: @escaping (Location?) -> Void) {
        do {
            try dbHelper.dbPool?.read { dbConnect in
                let result = try Location.fetchOne(dbConnect, sql: """
                SELECT city.country_code as country_code, country_name, city_name, latitude,
                       longitude, has_fixed_prayer_time
                FROM city
                INNER JOIN country on city.country_code = country.country_code
                WHERE city.country_code='\(countryCode)' COLLATE NOCASE and city.city_name='\(city)' COLLATE NOCASE
                """)

                guard var location = result else {
                    callback(nil)
                    return
                }

                callback(location)
            }
        } catch {
            callback(nil)
        }
    }

    /// Reverse geocoder to find city by it's latitude and longitude.
    ///
    /// - Parameters:
    ///   - latitude: City latitude.
    ///   - longitude: City longitude.
    ///   - callback: Callback that returns a Location object.
    public func geocoder(latitude: Double, longitude: Double, callback: @escaping (Location?) -> Void) {
        do {
            try dbHelper.dbPool?.read { dbConnect in
                let result = try Location.fetchOne(dbConnect, sql: """
                SELECT city.country_code as country_code, country_name, city_name, latitude,
                       longitude, has_fixed_prayer_time
                FROM city
                INNER JOIN country on city.country_code = country.country_code
                ORDER BY abs(latitude - (\(latitude))) + abs(longitude - (\(longitude)))
                LIMIT 1
                """)

                guard var location = result else {
                    callback(nil)
                    return
                }

                callback(location)
            }
        } catch {
            callback(nil)
        }
    }
}
