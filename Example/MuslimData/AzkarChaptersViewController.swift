//
//  AzkarChaptersViewController.swift
//  MuslimData_Example
//
//  Created by Kosrat D. Ahmad on 11/3/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import MuslimData
import UIKit

class AzkarChaptersViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet var chaptersTable: UITableView!

    // MARK: - Properties

    var chapters: [AzkarChapter] = []

    // MARK: - View Lifecycles

    override func viewDidLoad() {
        super.viewDidLoad()

        chaptersTable.delegate = self
        chaptersTable.dataSource = self

        // Get azkar chapters from MuslimData library.
        Task.init {
            let chapters = try! await MuslimRepository().getAzkarChapters(language: .en)
            self.chapters = chapters!
            self.chaptersTable.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension AzkarChaptersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "azkarController") as? AzkarDetailViewController
        controller?.azkarChapter = chapters[indexPath.row]
        navigationController?.pushViewController(controller!, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension AzkarChaptersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chapters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chapterCell", for: indexPath)
        let chapter = chapters[indexPath.row]
        cell.textLabel?.text = chapter.name

        return cell
    }
}
