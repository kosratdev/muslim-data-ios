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
    @State private var tab: AppTabs = .prayerTime
    var body: some View {
            TabView(selection: $tab) {
                Text("Prayer Time")
                    .tabItem {
                        Image("ic_nav_prayers")
                        Text("Prayer Time")
                    }.tag(1)
                NamesScreen()
                    .tabItem {
                        Image("ic_nav_names")
                        Text("Names")
                    }.tag(2)
                Text("Azkar")
                    .tabItem {
                        Image("ic_nav_azkars")
                        Text("Azkar")
                    }.tag(3)
            }
    }
}

#Preview {
    ContentView()
}
