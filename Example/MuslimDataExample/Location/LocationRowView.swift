//
//  LocationRowView.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import SwiftUI
import MuslimData

/// Displays a single row of the prayer times. Includes the prayer name and time.
///
/// - Parameters:
///   - location: The location instance.
///   - selectedLocation: The selected location instance.
struct LocationRowView: View {
    var location: Location
    @Binding var selectedLocation: Location
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.countryName)
            }
            
            Spacer()
            
            if selectedLocation.id == location.id {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.selectedLocation = location
        }
    }
}

#Preview {
    LocationRowView(location: Location.loadSavedLocation(),
                    selectedLocation: .constant(Location.loadSavedLocation())
    )
}
