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
    public let id: Int
    public let name: String
    public let latitude: Double
    public let longitude: Double
    public let countryCode: String
    public let countryName: String
    public var hasFixedPrayerTime: Bool
    public let prayerDependentId: Int?

    /// get columns from db.
    enum Columns {
        static let id = Column("_id")
        static let name = Column("name")
        static let latitude = Column("latitude")
        static let longitude = Column("longitude")
        static let countryCode = Column("country_code")
        static let countryName = Column("country_name")
        static let hasFixedPrayerTime = Column("has_fixed_prayer_time")
        static let prayerDependentId = Column("prayer_dependent_id")
    }

    /// put columns to row.
    ///
    /// - Parameter row: Row
    public init(row: Row) {
        id = row[Columns.id]
        name = row[Columns.name]
        latitude = row[Columns.latitude]
        longitude = row[Columns.longitude]
        countryCode = row[Columns.countryCode]
        countryName = row[Columns.countryName]
        hasFixedPrayerTime = row[Columns.hasFixedPrayerTime]
        prayerDependentId = row[Columns.prayerDependentId]
    }

    public init(id: Int, name: String, latitude: Double, longitude: Double, countryCode: String,
                countryName: String, hasFixedPrayerTime: Bool, prayerDependentId: Int?) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.countryCode = countryCode
        self.countryName = countryName
        self.hasFixedPrayerTime = hasFixedPrayerTime
        self.prayerDependentId = prayerDependentId
    }
}
