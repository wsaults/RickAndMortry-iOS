//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import SwiftUI

struct EpisodesView: View {
    @State private var viewModel: EpisodeViewModel
    
    init(viewModel: EpisodeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if viewModel.isLoading, viewModel.episodes.isEmpty {
                        ForEach(0..<5, id: \.self) { _ in
                            EpisodeRowPlaceholder()
                                .redacted(reason: .placeholder)
                        }
                    } else {
                        ForEach(viewModel.episodes) { episode in
                            NavigationLink(value: episode) {
                                EpisodeRow(episode: episode)
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
            }
            .task { await viewModel.fetchEpisodes() }
            .navigationTitle("Episodes")
            .navigationDestination(for: Episode.self) { episode in
                EpisodeDetailView(episode: episode)
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            }
        }
    }
}

struct EpisodeRow: View {
    let episode: Episode
    
    var body: some View {
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
    }
}

struct EpisodeRowPlaceholder: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Episode name goes here")
                .font(.headline)
            HStack {
                Text("S01E01")
                    .fontWeight(.bold)
                Text("Jan 1, 2023")
            }
            .font(.footnote)
        }
    }
}

#Preview {
    EpisodesView(
        viewModel: EpisodeViewModel(
            episodeService: MockEpisodeService(episodes: Episode.mock)
        )
    )
}
