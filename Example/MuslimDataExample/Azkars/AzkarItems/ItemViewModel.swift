//
//  ItemViewModel.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import Foundation
import MuslimData

@Observable
/// Manages the state for the azkar item list and responsible for fetching data.
class ItemViewModel {
    private(set) var azkarItems: [AzkarItem] = []
    let chapterId: Int
    
    init(chapterId: Int) {
        self.chapterId = chapterId
        getAzkarItems()
    }
    
    /// Fetches the azkar items from the `MuslimRepository`.
    private func getAzkarItems() {
        Task {
            do {
                azkarItems = try await MuslimRepository().getAzkarItems(chapterId: chapterId, language: .en) ?? []
            } catch {
                print("Error getting azkar items: \(error.localizedDescription)")
            }
        }
    }
}
