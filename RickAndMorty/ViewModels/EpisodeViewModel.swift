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
    private let characterService: CharacterFetching
    var episodes = [Episode]()
    var filteredEpisodes: [Episode] {
        if searchText.isEmpty {
            episodes
        } else {
            episodes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var errorMessage: String?
    var isLoading = false
    var searchText = ""
    
    init(
        episodeService: EpisodeFetching,
        characterService: CharacterFetching
    ) {
        self.episodeService = episodeService
        self.characterService = characterService
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
    
    @MainActor
    func fetchCharacter(from url: URL) async -> ShowCharacter? {
        var character: ShowCharacter?
        do {
            character = try await characterService.fetchCharacter(from: url)
        } catch {
            errorMessage = error.localizedDescription
        }
        return character
    }
}
