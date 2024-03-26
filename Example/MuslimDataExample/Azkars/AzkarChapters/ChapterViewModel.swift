//
//  AzkarViewModel.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import Foundation
import MuslimData

@Observable
/// Manages the state for the azkar chapters list and responsible for fetching data.
class ChapterViewModel {
    private(set) var azkarChapters: [AzkarChapter] = []
    
    init() {
        getAzkarChapters()
    }
    
    /// Fetches the azkar chapters from the `MuslimRepository`.
    private func getAzkarChapters() {
        Task {
            do {
                azkarChapters = try await MuslimRepository().getAzkarChapters(language: .en) ?? []
            } catch {
                print("Error loading azkars: \(error.localizedDescription)")
            }
        }
    }
}
