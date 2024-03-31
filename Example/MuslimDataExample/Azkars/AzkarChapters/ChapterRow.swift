//
//  AzkarRow.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import SwiftUI
import MuslimData

/// Displays a single row that is representing an azkar chapter.
///
/// - Parameters:
///   - azkarChapter: the `AzkarChapter` instance that needs to be displayed in the row.
struct ChapterRow: View {
    var azkarChapter: AzkarChapter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(azkarChapter.name)
                .font(.body)
        }
    }
}

#Preview {
    ChapterRow(azkarChapter: AzkarChapter(id: 1, categoryId: 1, name: "Morning Azkars"))
}
