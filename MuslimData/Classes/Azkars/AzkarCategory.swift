//
//  Azkar.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/13/18.
//

import Foundation
import GRDB

/// Azkar category model
public struct AzkarCategory: FetchableRecord {
    // MARK: - Properties

    public let id: Int
    public let name: String

    /// get columns from db.
    enum Columns {
        static let id = Column("_id")
        static let name = Column("category_name")
    }

    // MARK: - Constructors

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    public init(row: Row) {
        id = row[Columns.id]
        name = row[Columns.name]
    }
}
