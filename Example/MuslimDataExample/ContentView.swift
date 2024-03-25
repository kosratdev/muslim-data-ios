//
//
// ContentView.swift
// Example
//
// Created by Muhammad Azad on 23/03/2024
// Copyright © 2024 MuslimData. All rights reserved.
//
        

import SwiftUI

struct ContentView: View {
    @State private var selection: AppTabs = .prayerTime
    enum AppTabs {
        case prayerTime
        case names
        case azkar
    }
    
    var body: some View {
            TabView(selection: $selection) {
                Text("Prayer Time")
                    .tabItem {
                        Image("ic_nav_prayers")
                        Text("Prayer Times")
                    }.tag(AppTabs.prayerTime)
                NamesScreen()
                    .tabItem {
                        Image("ic_nav_names")
                        Text("Names")
                    }.tag(AppTabs.names)
                AzkarChaptersScreen()
                    .tabItem {
                        Image("ic_nav_azkars")
                        Text("Azkar")
                    }.tag(AppTabs.azkar)
            }
    }
}

#Preview {
    ContentView()
}
