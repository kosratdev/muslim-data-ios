//
//  Name.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/11/18.
//

import Foundation
import GRDB

/// Name medel that represents a name with it's translation.
public struct Name: FetchableRecord {
    // MARK: - Properties

    public let name: String
    public let translated: String

    /// get columns from db.
    enum Columns {
        static let name = Column("name")
        static let translated = Column("translated")
    }

    // MARK: - Constructors

    public init(name: String, translated: String) {
        self.name = name
        self.translated = translated
    }

    public init(row: Row) {
        name = row[Columns.name]
        translated = row[Columns.translated]
    }
}
