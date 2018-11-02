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
                    let locations = try Location.fetchAll(dbConnect, """
                    SELECT cities.country_code as country_code, cities.city as city, cities.latitude as latitude,
                    cities.longitude as longitude, countries.country_name as country_name
                    FROM cities
                    INNER JOIN countries on cities.country_code = countries.country_code
                    WHERE cities.city like '\(city)%'
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
                let result = try Location.fetchOne(dbConnect, """
                SELECT cities.country_code as country_code, cities.city as city, cities.latitude as latitude,
                cities.longitude as longitude, countries.country_name as country_name
                FROM cities
                INNER JOIN countries on cities.country_code = countries.country_code
                WHERE cities.country_code='\(countryCode)' and cities.city='\(city)'
                """)

                guard var location = result else {
                    callback(nil)
                    return
                }

                let isStatic = try Bool.fetchOne(
                    dbConnect, """
                    SELECT * FROM prayer_times
                    where country_code = '\(location.countryCode)' and
                    city = '\(location.city.mapper(countryCode: location.countryCode))'
                    """
                )
                location.hasFixedPrayerTimes = isStatic ?? false
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
                let result = try Location.fetchOne(dbConnect, """
                SELECT cities.country_code as country_code, cities.city as city, cities.latitude as latitude,
                cities.longitude as longitude, countries.country_name as country_name
                FROM cities
                INNER JOIN countries on cities.country_code = countries.country_code
                ORDER BY abs(latitude - (\(latitude))) + abs(longitude - (\(longitude)))
                LIMIT 1
                """)

                guard var location = result else {
                    callback(nil)
                    return
                }

                let hasFixed = try Bool.fetchOne(
                    dbConnect, """
                    SELECT * FROM prayer_times
                    where country_code='\(location.countryCode)' and
                    city = '\(location.city.mapper(countryCode: location.countryCode))'
                    """
                )
                location.hasFixedPrayerTimes = hasFixed ?? false
                callback(location)
            }
        } catch {
            callback(nil)
        }
    }

    /// Check whether the city has fixed prayer times or not.
    ///
    /// - Parameters:
    ///   - city: City name.
    ///   - callback: Callback that returns a Boolean that indicate the city has fixed prayer times or not.
    public func cityHasFixedPrayerTimes(countryCode: String, city: String, callback: @escaping (Bool) -> Void) {
        do {
            try dbHelper.dbPool?.read { dbConnect in
                let result = try Bool.fetchOne(dbConnect, """
                SELECT * FROM prayer_times
                WHERE country_code='\(countryCode)' and
                city = '\(city.mapper(countryCode: countryCode))'
                """)
                callback(result ?? false)
            }
        } catch {
            callback(false)
        }
    }
}
