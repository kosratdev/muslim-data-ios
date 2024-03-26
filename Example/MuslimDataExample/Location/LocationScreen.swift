//
//  LocationScreen.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import SwiftUI
import MuslimData

/// Location screen that displays the selected location and searching for locations.
struct LocationScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    var locationViewModel = LocationViewModel()
    var prayerViewModel: PrayerViewModel
    
    @State var searchKeyword: String = ""
    @State var selectedLocation: Location = Location.loadSavedLocation()
    
    var body: some View {
        List {
            Section(header: Text("Selected location")) {
                VStack(alignment: .leading){
                    Text(selectedLocation.name)
                        .font(.headline)
                    Text(selectedLocation.countryName)
                }
            }

            if locationViewModel.locations.count > 0 {
                Section(header: Text("Search Result")) {
                    ForEach(locationViewModel.locations, id: \.id) { location in
                        LocationRowView(location: location, selectedLocation: $selectedLocation)
                    }
                }
            }
        }
        .listSectionSpacing(8)
        .navigationTitle("Locations")
        .searchable(text: $searchKeyword,
                    placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchKeyword) { oldValue, newValue in
            if !newValue.isEmpty && newValue.count > 2 {
                locationViewModel.searchResult(searchKeyword: newValue)
            } else {
                locationViewModel.locations.removeAll()
            }
        }
        .toolbar {
            Button {
                selectedLocation.saveLocation()
                prayerViewModel.updatePrayerTimes()
                dismiss()
            } label: {
                Text("Save")
            }
        }
    }
}

#Preview {
    LocationScreen(prayerViewModel: PrayerViewModel())
}
