//
//  PrayersViewController.swift
//  MuslimData_Example
//
//  Created by Kosrat D. Ahmad on 11/2/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import MuslimData
import UIKit

class PrayersViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet var locationDetail: UILabel!
    @IBOutlet var prayerTable: UITableView!

    // MARK: - Properties

    var prayerTimes: [String] = []
    let prayerNames = ["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"]

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prayerTable.dataSource = self
        prayerTable.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Get prayer times
        Task.init {
            try! await getPrayers()
        }
    }

    // MARK: - Helper Methods

    /// Get prayer times from the MuslimData library
    func getPrayers() async throws {
        let offsets = [Double](repeating: 0, count: 6)
        let location = Location.loadSavedLocation()
        let attributes = PrayerAttribute(method: .makkah, asrMethod: .shafii, adjustAngle: .angleBased, offsets: offsets)

        let prayer = try await MuslimRepository().getPrayerTimes(location: location, date: Date(), attributes: attributes)
        prayerTimes = prayer!.formatPrayers(.time12)
        prayerTable.reloadData()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatter.string(from: Date())

        locationDetail.text = "\(location.name), \(location.countryName)\n\(stringDate)"
    }
}

// MARK: - UITableViewDataSource

extension PrayersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        prayerTimes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prayerCell", for: indexPath)
        cell.textLabel?.text = prayerNames[indexPath.row]
        cell.detailTextLabel?.text = prayerTimes[indexPath.row]

        return cell
    }
}
