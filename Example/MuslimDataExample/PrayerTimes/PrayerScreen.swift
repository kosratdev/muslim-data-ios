//
//  PrayerTimes.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import SwiftUI
import MuslimData

/// Displays a list of the prayer times.
struct PrayerScreen: View {
    var prayerViewModel = PrayerViewModel()
    var prayerNames: [String] {
        prayerViewModel.prayerNames
    }
    var location: Location {
        prayerViewModel.location
    }
    var prayerTimes: [String] {
        prayerViewModel.prayerTimes
    }

    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .leading) {
                    Text("\(location.name), \(location.countryCode)")
                        .font(.headline)
                    Text(prayerViewModel.todayString())
                }.padding(.bottom)
                
                if prayerTimes.count > 0 {
                    ForEach(Array(prayerNames.enumerated()), id: \.offset) { index, name in
                        PrayerRowView(prayerName: name, prayerTime: prayerTimes[index])
                    }
                }
            }
            .navigationTitle("My Prayers")
            .toolbar {
                Button {
                    print("Navigate to location screen")
                } label: {
                    Image("ic_location")
                }
            }
        }
    }
}

#Preview {
    PrayerScreen()
}
