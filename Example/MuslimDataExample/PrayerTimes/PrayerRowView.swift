//
//  PrayerRow.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import SwiftUI
import MuslimData

/// Displays a single row of the prayer times. Includes the prayer name and time.
///
/// - Parameters:
///   - prayerName: The prayer name string.
///   - prayerTime: The formatted prayer time string.
struct PrayerRowView: View {
    let prayerName: String
    let prayerTime: String
    
    var body: some View {
        HStack {
            Text(prayerName)
            Spacer()
            Text(prayerTime)
        }
    }
}

#Preview {
    PrayerRowView(prayerName: "Fajr", prayerTime: "04:55 AM")
}
