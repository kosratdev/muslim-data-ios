//
//  Location.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/3/18.
//

import Foundation
import GRDB

/// Location model that holds a location information.
struct Location: FetchableRecord {
    let latitude: Double
    let longitude: Double
    let city: String
    let countryCode: String
    var isStatic = false

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
    init(row: Row) {
        latitude = row[Columns.latitude]
        longitude = row[Columns.longitude]
        city = row[Columns.city]
        countryCode = row[Columns.countryCode]
    }
}
