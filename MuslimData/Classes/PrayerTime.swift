//
//  PrayerTimes.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 9/28/18.
//

import Foundation
import GRDB

/// Prayer times object that will be use to get static prayer times from database.
public struct PrayerTime: FetchableRecord {
    public var fajr: String
    public var sunrise: String
    public var zuhr: String
    public var asr: String
    public var maghrib: String
    public var isha: String

    /// get columns from db.
    enum Columns {
        static let fajr = Column("fajr")
        static let sunrise = Column("sunrise")
        static let zuhr = Column("dhuhr")
        static let asr = Column("asr")
        static let maghrib = Column("maghrib")
        static let isha = Column("isha")
    }

    /// put columns to row.
    ///
    /// - Parameter row: Row
    public init(row: Row) {
        fajr = row[Columns.fajr]
        sunrise = row[Columns.sunrise]
        zuhr = row[Columns.zuhr]
        asr = row[Columns.asr]
        maghrib = row[Columns.maghrib]
        isha = row[Columns.isha]
    }
}
