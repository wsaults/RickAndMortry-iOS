//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import SwiftUI

@Observable
class CharactersViewModel {
    private let characterService: CharacterFetching
    var characters = [ShowCharacter]()
    var errorMessage: String?
    var isLoading = false
    
    init(characterService: CharacterFetching) {
        self.characterService = characterService
    }
    
    @MainActor
    func fetchCharacters() async {
        isLoading = true
        defer { isLoading = false }
        do {
            characters += try await characterService.fetchCharacters()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
