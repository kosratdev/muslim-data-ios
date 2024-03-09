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
    ///   - locationName: location name
    ///   - callback: Callback that returns a Location object.
    public func citySearch(_ locationName: String, callback: @escaping ([Location]?, String?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                try self.dbHelper.dbPool?.read { dbConnect in
                    let locations = try Location.fetchAll(dbConnect, sql: """
                    SELECT location._id as _id, country.code as country_code, country.name as country_name,
                           location.name as name, latitude, longitude, has_fixed_prayer_time, prayer_dependent_id
                    FROM location
                    INNER JOIN country on country._id = location.country_id
                    WHERE location.name like "\(locationName)%"
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
    public func geocoder(countryCode: String, locationName: String, callback: @escaping (Location?) -> Void) {
        do {
            try dbHelper.dbPool?.read { dbConnect in
                let result = try Location.fetchOne(dbConnect, sql: """
                SELECT location._id as _id, country.code as country_code, country.name as country_name, 
                       location.name as name, latitude, longitude, has_fixed_prayer_time, prayer_dependent_id
                FROM location
                INNER JOIN country on country._id = location.country_id
                WHERE country.code="\(countryCode)" COLLATE NOCASE and location.name="\(locationName)" COLLATE NOCASE
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
                SELECT location._id as _id, country.code as country_code, country.name as country_name,
                       location.name as name, latitude, longitude, has_fixed_prayer_time, prayer_dependent_id
                FROM location
                INNER JOIN country on country._id = location.country_id
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
    
    /// Get all the locations that has fixed prayer times.
    /// - Returns: Location list
    public func fixedPrayerTimesList() -> [Location]?{
        do {
            return try self.dbHelper.dbPool?.read { dbConnect in
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
