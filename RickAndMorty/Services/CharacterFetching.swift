//
//  CharacterFetching.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import Foundation

protocol CharacterFetching {
    func fetchCharacters() async throws -> [ShowCharacter]
}

class CharacterService: CharacterFetching {
    var pageInfo: PageInfo?
    var requestURL = URL(string: "https://rickandmortyapi.com/api/character")!
    
    func fetchCharacters() async throws(NetworkError) -> [ShowCharacter] {
        var url = requestURL
        if let info = pageInfo {
            if let nextUrl = info.next {
                url = nextUrl
            } else {
                return []
            }
        }
        
        let request = URLRequest(url: url)
        let result: (Data, URLResponse)
        do {
            result = try await URLSession.shared.data(for: request)
        } catch {
            throw .badRequest
        }
        
        let characters: [ShowCharacter]
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            let result = try decoder.decode(CharactersResult.self, from: result.0)
            characters = result.results
            pageInfo = result.info
        } catch {
            throw .jsonDecoding
        }
        
        return characters
    }
}

struct MockCharacterService: CharacterFetching {
    var characters: [ShowCharacter]
    
    func fetchCharacters() async throws -> [ShowCharacter] {
        characters
    }
}
