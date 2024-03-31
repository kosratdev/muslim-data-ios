//
//  AzkarDetailScreen.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import SwiftUI

/// Display the detail of the selected azkar chapter. 
struct AzkarItemsScreen: View {
    var itemsViewModel: ItemViewModel
    
    init(chapterId: Int) {
        itemsViewModel = ItemViewModel(chapterId: chapterId)
    }
    
    var body: some View {
        List {
            ForEach(itemsViewModel.azkarItems, id: \.id) { item in
                ItemRow(azkarItem: item)
            }
        }
        .listRowSpacing(8)
        .navigationTitle("Azkar Details")
    }
}

#Preview {
    AzkarItemsScreen(chapterId: 1)
}
