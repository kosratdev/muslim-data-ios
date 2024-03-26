//
//
// NamesViewModel.swift
// Example
//
// Created by Muhammad Azad on 23/03/2024
// Copyright © 2024 MuslimData. All rights reserved.
//
        

import Foundation
import MuslimData

@Observable
/// Manages the state for a list of Names of Allah and responsible for fetching data.
class NamesViewModel {
    private(set) var names: [Name] = []

    init() {
        getNamesOfAllah()
    }

    /// Fetches the Names of Allah from the `MuslimRepository`.
    func getNamesOfAllah() {
        Task {
            do {
                names = try await MuslimRepository().getNamesOfAllah(language: .en) ?? []
            } catch {
                print("Error getting names: \(error.localizedDescription)")
            }
        }
    }
}

