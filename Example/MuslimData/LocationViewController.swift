//
//  LocationViewController.swift
//  MuslimData_Example
//
//  Created by Kosrat D. Ahmad on 10/30/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import MuslimData
import UIKit

class LocationViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet var locationTitle: UILabel!
    @IBOutlet var locationTable: UITableView!

    var locations: [Location] = [] {
        didSet {
            locationTable.reloadData()
        }
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchBar()
            navigationItem.searchController?.searchBar.placeholder = "Search locations"
        }

        locationTable.delegate = self
        locationTable.dataSource = self

        displayLocation()
    }

    // MARK: - Helper Methods

    /// Create search controller.
    ///
    /// - Returns: UISearchController
    func searchBar() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        return searchController
    }

    /// Display selected location on the screen.
    func displayLocation() {
        let location = Location.loadSavedLocation()
        locationTitle.text = "\(location.name), \(location.countryName)"
    }

    /// Dismiss and return to the parent screen.
    ///
    /// - Parameter sender: Any
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate

extension LocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            locations.removeAll()
            return
        }
        Task.init {
            let locations = try! await MuslimRepository().searchLocation(locationName: searchBar.text!)
            if let locations = locations {
                self.locations = locations
            }
        }
    }
}

// MARK: - UITableViewDelegate

extension LocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]

        location.saveLocation()
        displayLocation()
        if #available(iOS 11.0, *) {
            navigationItem.searchController?.isActive = false
        }
    }
}

// MARK: - UITableViewDataSource

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        let location = locations[indexPath.row]
        cell.textLabel?.text = location.name
        cell.detailTextLabel?.text = location.countryName

        return cell
    }
}
