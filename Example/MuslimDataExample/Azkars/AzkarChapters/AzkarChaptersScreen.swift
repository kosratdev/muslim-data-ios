//
//  AzkarsScreen.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import SwiftUI

/// Display the azkar chapter list.
struct AzkarChaptersScreen: View {
    private var azkarViewModel = ChapterViewModel()
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(azkarViewModel.azkarChapters, id: \.id) { chapter in
                    NavigationLink {
                        AzkarItemsScreen(chapterId: chapter.id)
                    } label: {
                        ChapterRow(azkarChapter: chapter)
                            .frame(height: 36)
                    }
                }
            }
            .navigationTitle("Azkars")
        } detail: {
            Text("Select an Azkar")
        }
    }
}

#Preview {
    AzkarChaptersScreen()
}
