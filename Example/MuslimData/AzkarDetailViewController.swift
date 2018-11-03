//
//  AzkarDetailViewController.swift
//  MuslimData_Example
//
//  Created by Kosrat D. Ahmad on 11/3/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MuslimData

class AzkarDetailViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet weak var azkarTable: UITableView!

    // MARK: - Properties

    var azkarChapter: AzkarChapter?
    var azkars: [AzkarItem] = []

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = azkarChapter!.name

        azkarTable.dataSource = self
        azkarTable.tableFooterView = UIView()

        // Get azkar items from MuslimData library.
        Azkars.azkarItems(language: .en, chapterId: azkarChapter!.id) { azkars, error in
            guard error == nil else {
                print("Prayer tims didn't found for the specified properties.")
                return
            }
            self.azkars = azkars!
            self.azkarTable.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension AzkarDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return azkars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "azkarCell", for: indexPath)
        let azkar = azkars[indexPath.row]
        cell.textLabel?.text = azkar.item
        cell.detailTextLabel?.text = "\(azkar.translation) \n\nReference: \(azkar.reference)"

        return cell
    }
}
