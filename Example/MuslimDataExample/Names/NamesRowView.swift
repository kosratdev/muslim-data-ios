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

/// Displays a single row which is representing a Name of Allah. Includes the Arabic name 
/// and its translation.
///
/// - Parameters:
///   - name: The `Name` instance that needs to be displayed in the row.
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
    NamesRowView(name: .init(name: "اللە", translated: "Allah"))
}
