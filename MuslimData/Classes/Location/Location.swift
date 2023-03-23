//
//  Location.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/3/18.
//

import Foundation
import GRDB

/// Location model that holds a location information.
public struct Location: FetchableRecord {
    public let latitude: Double
    public let longitude: Double
    public let cityName: String
    public let countryCode: String
    public let countryName: String
    public var hasFixedPrayerTime: Bool

    /// get columns from db.
    enum Columns {
        static let latitude = Column("latitude")
        static let longitude = Column("longitude")
        static let cityName = Column("city_name")
        static let countryCode = Column("country_code")
        static let countryName = Column("country_name")
        static let hasFixedPrayerTime = Column("has_fixed_prayer_time")
    }

    /// put columns to row.
    ///
    /// - Parameter row: Row
    public init(row: Row) {
        latitude = row[Columns.latitude]
        longitude = row[Columns.longitude]
        cityName = row[Columns.cityName]
        countryCode = row[Columns.countryCode]
        countryName = row[Columns.countryName]
        hasFixedPrayerTime = row[Columns.hasFixedPrayerTime]
    }

    public init(latitude: Double, longitude: Double, cityName: String,
                countryCode: String, countryName: String, hasFixedPrayerTime: Bool) {
        self.latitude = latitude
        self.longitude = longitude
        self.cityName = cityName
        self.countryCode = countryCode
        self.countryName = countryName
        self.hasFixedPrayerTime = hasFixedPrayerTime
    }
}
