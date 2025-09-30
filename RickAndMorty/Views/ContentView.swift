//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var episodeService = EpisodeService()
    @State private var characterService = CharacterService()
    @State private var locationService = LocationService()
    
    var body: some View {
        TabView {
            Tab("Episodes", systemImage: "list.bullet") {
                EpisodesView(viewModel: EpisodeViewModel(episodeService: episodeService))
            }
            
            Tab("Characters", systemImage: "person.3") {
                CharactersView(viewModel: CharactersViewModel(characterService: characterService))
            }
            
            Tab("Locations", systemImage: "mappin.and.ellipse") {
                LocationsView(viewModel: LocationsViewModel(locationService: locationService))
            }
        }
    }
}

#Preview {
    ContentView()
}
