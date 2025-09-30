//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var episodeService = EpisodeService()
    
    var body: some View {
        TabView {
            Tab("Episodes", systemImage: "list.bullet") {
                EpisodesView(viewModel: ContentViewModel(episodeService: episodeService))
            }
            
            Tab("Characters", systemImage: "person.3") {
                Text("Characters View")
            }
            
            Tab("Locations", systemImage: "mappin.and.ellipse") {
                Text("Locations View")
            }
        }
    }
}

#Preview {
    ContentView()
}
