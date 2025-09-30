//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import SwiftUI

struct EpisodesView: View {
    @State private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.episodes) { episode in
                    NavigationLink(value: episode) {
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
            }
            .task { await viewModel.fetchEpisodes() }
            .navigationTitle("Episodes")
            .navigationDestination(for: Episode.self) { episode in
                EpisodeDetailView(episode: episode)
            }
        }
    }
}

#Preview {
    EpisodesView(
        viewModel: ContentViewModel(
            episodeService: MockEpisodeService(episodes: Episode.mock)
        )
    )
}
