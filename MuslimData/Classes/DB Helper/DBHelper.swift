//
//  DBHelper.swift
//  GRDB.swift
//
//  Created by Kosrat D. Ahmad on 9/27/18.
//

import UIKit
import GRDB

class DBHelper {
    // MARK: - Properties

    var dbQueue: DatabaseQueue?
    static let shared = DBHelper()

    // MARK: - Life cycle

    private init() {
        let databaseURL = Bundle(for: DBHelper.self).path(forResource: "PrayersDb", ofType: "db")!
        dbQueue = try? DatabaseQueue(path: databaseURL)

        // Be a nice iOS citizen, and don’t consume too much memory
        // See https://github.com/groue/GRDB.swift/#memory-management
        dbQueue?.setupMemoryManagement(in: UIApplication.shared)
    }
}
