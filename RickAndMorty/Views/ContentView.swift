//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.episodes) { episode in
                    VStack(alignment: .leading) {
                        Text(episode.name)
                            .font(.headline)
                        HStack {
                            Text(episode.episode)
                                .fontWeight(.bold)
                            Text(episode.airDate)
                        }
                        .font(.footnote)
                    }
                    .onAppear {
                        if episode.id == viewModel.episodes.last?.id {
                            Task {
                                await viewModel.fetchEpisodes()
                            }
                        }
                    }
                }
            }
            .task { await viewModel.fetchEpisodes() }
            .navigationTitle("Episodes")
        }
    }
}

#Preview {
    ContentView(
        viewModel: ContentViewModel(
            episodeService: MockEpisodeService(episodes: Episode.mock)
        )
    )
}
