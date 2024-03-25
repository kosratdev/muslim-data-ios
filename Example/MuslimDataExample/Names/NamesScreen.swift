//
//
// NamesScreen.swift
// Example
//
// Created by Muhammad Azad on 23/03/2024
// Copyright © 2024 MuslimData. All rights reserved.
//


import SwiftUI

/// Displays a list of the Names of Allah.
struct NamesScreen: View {
    private var viewModel = NamesViewModel()
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(viewModel.names, id: \.name) { name in
                    NamesRowView(name: name)
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
