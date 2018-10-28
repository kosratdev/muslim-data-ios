//
//  AzkarChapter.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/14/18.
//

import Foundation
import GRDB

/// Azkar chapter model.
public struct AzkarChapter: FetchableRecord {
    // MARK: - Properties

    public let id: Int
    public let categoryId: Int
    public let name: String

    /// get columns from db.
    enum Columns {
        static let id = Column("_id")
        static let categoryId = Column("category_id")
        static let name = Column("category_name")
    }

    // MARK: - Constructors

    public init(id: Int, categoryId: Int, name: String) {
        self.id = id
        self.categoryId = categoryId
        self.name = name
    }

    public init(row: Row) {
        id = row[Columns.id]
        categoryId = row[Columns.categoryId]
        name = row[Columns.name]
    }
}
