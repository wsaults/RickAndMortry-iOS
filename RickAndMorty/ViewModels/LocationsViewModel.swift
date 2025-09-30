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
    var errorMessage: String?
    var isLoading = false
    
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
