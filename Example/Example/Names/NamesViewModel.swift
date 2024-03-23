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

/// Manages the state for a list of Names of Allah. Responsible for fetching data, handling loading states, and potential errors.
class NamesViewModel: ObservableObject {
    @Published private(set) var names: [Name] = []
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error? = nil

    /// Initializes the view model and starts fetching the Names of Allah.
    init() {
        getNamesOfAllah()
    }

    /// Fetches the Names of Allah from the `MuslimRepository`. Manages loading and error states.
    func getNamesOfAllah() {
        Task {
            isLoading = true
            do {
                names = try await MuslimRepository().getNamesOfAllah(language: .en) ?? []
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
}

