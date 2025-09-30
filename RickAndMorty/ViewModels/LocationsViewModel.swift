//
//  LocationsViewModel.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/30/25.
//

import SwiftUI

@Observable
class LocationsViewModel {
    private let locationService: LocationFetching
    var locations = [ShowLocation]()
    var filteredLocations: [ShowLocation] {
        if searchText.isEmpty {
            locations
        } else {
            locations.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    var errorMessage: String?
    var isLoading = false
    var searchText = ""
    
    init(locationService: LocationFetching) {
        self.locationService = locationService
    }
    
    @MainActor
    func fetchLocations() async {
        isLoading = true
        defer { isLoading = false }
        do {
            locations += try await locationService.fetchLocations()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
