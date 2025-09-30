//
//  EpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import Foundation

@Observable
class EpisodeViewModel {
    private let episodeService: EpisodeFetching
    var episodes = [Episode]()
    var errorMessage: String?
    var isLoading = false
    
    init(episodeService: EpisodeFetching) {
        self.episodeService = episodeService
    }
    
    @MainActor
    func fetchEpisodes() async {
        isLoading = true
        defer { isLoading = false }
        do {
            episodes += try await episodeService.fetchEpisodes()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
