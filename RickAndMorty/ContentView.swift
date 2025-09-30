//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import SwiftUI

protocol EpisodeFetching {
    func fetchEpisodes() async throws -> [Episode]
}

@Observable
class EpisodeService: EpisodeFetching {
    private var pageInfo: PageInfo?
    var page: Int = 0
    var episodeURL: URL {
        URL(string: "https://rickandmortyapi.com/api/episode")!
    }
    
    enum NetworkError: Error {
        case jsonDecoding
        case badRequest
    }
    
    func fetchEpisodes() async throws -> [Episode] {
        var requestURL = episodeURL
        if let pageInfo = pageInfo {
            if let url = pageInfo.next {
                requestURL = url
            } else {
                return []
            }
        }

        let request = URLRequest(url: requestURL)
        let result: (Data, URLResponse)
        do {
            result = try await URLSession.shared.data(for: request)
        } catch {
            throw NetworkError.badRequest
        }
        
        var episodes = [Episode]()
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            let result = try decoder.decode(EpisodesResult.self, from: result.0)
            episodes = result.results
            pageInfo = result.info
        } catch {
            throw NetworkError.jsonDecoding
        }
        
        page += 1
        return episodes
    }
}

struct MockEpisodeService: EpisodeFetching {
    var episodes: [Episode]
    
    func fetchEpisodes() async throws -> [Episode] {
        episodes
    }
}

@Observable
class ContentViewModel {
    private var episodeService: EpisodeFetching
    var episodes = [Episode]()
    
    init(episodeService: EpisodeFetching) {
        self.episodeService = episodeService
    }
    
    @MainActor
    func fetchEpisodes() async {
        do {
            episodes += try await episodeService.fetchEpisodes()
        } catch {
            // TODO: Handle error
        }
    }
}

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
