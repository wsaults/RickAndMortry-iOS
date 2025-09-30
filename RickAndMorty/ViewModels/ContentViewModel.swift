//
//  ContentViewModel.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import Foundation

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
