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
    public let city: String
    public let countryCode: String
    public var isStatic = false

    /// get columns from db.
    enum Columns {
        static let latitude = Column("latitude")
        static let longitude = Column("longitude")
        static let city = Column("city")
        static let countryCode = Column("country_code")
    }

    /// put columns to row.
    ///
    /// - Parameter row: Row
    public init(row: Row) {
        latitude = row[Columns.latitude]
        longitude = row[Columns.longitude]
        city = row[Columns.city]
        countryCode = row[Columns.countryCode]
    }

    public init(latitude: Double, longitude: Double, city: String, countryCode: String, isStatic: Bool) {
        self.latitude = latitude
        self.longitude = longitude
        self.city = city
        self.countryCode = countryCode
        self.isStatic = isStatic
    }
}
