//
//  ItemRow.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import SwiftUI
import MuslimData

/// Displays a single row that is representing an Azkar Item. Includes the Arabic azkar, its tranlation,
/// and the azkar reference.
///
/// - Parameters:
///   - azkarItem: the `AzkarItem` instance that needs to be displayed in the row.
struct ItemRow: View {
    var azkarItem: AzkarItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(azkarItem.item)
                .font(.headline)
                .padding(.bottom, 4)
            Text(azkarItem.translation)
                .font(.body)
                .padding(.bottom, 8)
            Text(azkarItem.reference)
                .font(.caption)
        }
    }
}

#Preview {
    ItemRow(azkarItem: AzkarItem(
        id: 1,
        chapterId: 1,
        item: "Azkar detail in Arabic language",
        translation: "translated azkar into user's language",
        reference: "Azkar references")
    )
}
