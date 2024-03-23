//
//
// NamesRowView.swift
// Example
//
// Created by Muhammad Azad on 23/03/2024
// Copyright © 2024 MuslimData. All rights reserved.
//
        

import SwiftUI
import MuslimData

/// Displays a single row representing a Name of Allah. Includes the Arabic name and its translation.
///
/// - Parameter:
///   - name: The `Name` data to be displayed in the row.
struct NamesRowView: View {
    let name: Name
    var body: some View {
        VStack(alignment: .leading){
            Text(name.name)
                .font(.body)
            Text(name.translated)
                .font(.caption)
        }
    }
}

#Preview {
    NamesRowView(name: .init(name: "", translated: ""))
}
