//
//  NamesViewController.swift
//  MuslimData_Example
//
//  Created by Kosrat D. Ahmad on 11/2/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import MuslimData
import UIKit

class NamesViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet var namesTable: UITableView!

    // MARK: - Properties

    var names: [Name] = []

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        namesTable.dataSource = self

        // Get names of allah from MuslimData.
        Names.names(language: .en) { names, error in
            guard error == nil else {
                return
            }
            self.names = names!
            self.namesTable.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource

extension NamesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath)
        let name = names[indexPath.row]
        cell.textLabel?.text = name.name
        cell.detailTextLabel?.text = name.translated

        return cell
    }
}
