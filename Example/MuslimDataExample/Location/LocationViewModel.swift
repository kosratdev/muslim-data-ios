//
//  LocationViewModel.swift
//  Example
//
//  Created by Kosrat Ahmed on 25/03/2024.
//

import Foundation
import MuslimData

@Observable
/// Manages the state for the location list and responsible for searching a location in the MuslimData.
class LocationViewModel {
    var locations: [Location] = []
    
    /// Search for location in the `MuslimRepository`.
    /// - Parameter searchKeyword: Location search keyword.
    func searchResult(searchKeyword: String) {
        Task {
            do {
                locations = try await MuslimRepository().searchLocation(locationName: searchKeyword) ?? []
            } catch {
                print("Error searching for locations: \(error.localizedDescription)")
            }
        }
    }
}
