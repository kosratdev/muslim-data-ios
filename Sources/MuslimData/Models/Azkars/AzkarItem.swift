//
//  AzkarItem.swift
//  MuslimData
//
//  Created by Kosrat D. Ahmad on 10/14/18.
//

import Foundation
import GRDB

/// Azkar Item model.
public struct AzkarItem: FetchableRecord {
    // MARK: - Properties

    public let id: Int
    public let chapterId: Int
    public let item: String
    public let translation: String
    public let reference: String

    /// get columns from db.
    enum Columns {
        static let id = Column("_id")
        static let chapterId = Column("chapter_id")
        static let item = Column("item")
        static let translation = Column("item_translation")
        static let reference = Column("reference")
    }

    // MARK: - Constructors

    public init(id: Int, chapterId: Int, item: String, translation: String, reference: String) {
        self.id = id
        self.chapterId = chapterId
        self.item = item
        self.translation = translation
        self.reference = reference
    }

    public init(row: Row) {
        id = row[Columns.id]
        chapterId = row[Columns.chapterId]
        item = row[Columns.item]
        translation = row[Columns.translation]
        reference = row[Columns.reference]
    }
}
