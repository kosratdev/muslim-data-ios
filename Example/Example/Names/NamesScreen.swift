//
//
// NamesScreen.swift
// Example
//
// Created by Muhammad Azad on 23/03/2024
// Copyright © 2024 MuslimData. All rights reserved.
//


import SwiftUI

/// Displays a list of the Names of Allah. Handles loading, error states, and data presentation.
struct NamesScreen: View {
    @ObservedObject private var viewModel = NamesViewModel()
    
    var body: some View {
        NavigationStack{
            List {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.error {
                    ErrorWithRetryView(title: "Error loading names!",
                                       errorMessage: error.localizedDescription) {
                        viewModel.getNamesOfAllah()
                    }
                } else {
                    ForEach(viewModel.names, id: \.name) { name in
                        NamesRowView(name: name)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Names of Allah")
        }
    }
}

#Preview {
    NamesScreen()
}
