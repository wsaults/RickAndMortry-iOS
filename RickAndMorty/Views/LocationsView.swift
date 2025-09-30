//
//  LocationsView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/30/25.
//

import SwiftUI

struct LocationsView: View {
    @State private var viewModel: LocationsViewModel
    
    init(viewModel: LocationsViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if viewModel.isLoading, viewModel.locations.isEmpty {
                        ForEach(0..<5, id: \.self) { _ in
                            LocationRowPlaceholder()
                                .redacted(reason: .placeholder)
                        }
                    }
                    ForEach(viewModel.locations) { location in
                        NavigationLink(value: location) {
                            LocationRow(location: location)
                        }
                        .onAppear {
                            if location.id == viewModel.locations.last?.id {
                                Task {
                                    await viewModel.fetchLocations()
                                }
                            }
                        }
                    }
                }
            }
            .task { await viewModel.fetchLocations() }
            .navigationTitle("Locations")
            .navigationDestination(for: ShowLocation.self) { location in
                LocationDetailView(location: location)
            }
        }
    }
}

struct LocationRow: View {
    let location: ShowLocation
    
    var body: some View {
        Text(location.name)
    }
}

struct LocationRowPlaceholder: View {
    var body: some View {
        Text("Earth")
    }
}

#Preview {
    LocationsView(viewModel: LocationsViewModel(locationService: MockLocationService(locations: ShowLocation.mock)))
}
