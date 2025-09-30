//
//  EpisodeFetching.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import Foundation

protocol EpisodeFetching {
    func fetchEpisodes() async throws -> [Episode]
}

@Observable
class EpisodeService: EpisodeFetching {
    private var pageInfo: PageInfo?
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
        
        return episodes
    }
}

struct MockEpisodeService: EpisodeFetching {
    var episodes: [Episode]
    
    func fetchEpisodes() async throws -> [Episode] {
        episodes
    }
}
