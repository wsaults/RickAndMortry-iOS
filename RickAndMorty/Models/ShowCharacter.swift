//
//  ShowCharacter.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import Foundation

struct CharactersResult: Decodable {
    let info: PageInfo
    let results: [ShowCharacter]
}

struct ShowCharacter: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let status: StatusType
    let species: String
    let type: String
    let gender: Gender
    let origin: LocationModel
    let location: LocationModel
    let image: URL
    let episode: [URL]
    let url: URL?
    
    enum StatusType: String, Decodable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown
    }
    
    enum Gender: String, Decodable {
        case male = "Male"
        case female = "Female"
        case genderless = "Genderless"
        case unknown
    }
    
    struct LocationModel: Decodable, Hashable {
        let name: String
        let url: String
    }
    
    static var mock: [ShowCharacter] {
        [
            .init(
                id: 1,
                name: "Rick Sanchez",
                status: .alive,
                species: "Human",
                type: "",
                gender: .male,
                origin: LocationModel(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                location: LocationModel(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
                episode: [
                    URL(string: "https://rickandmortyapi.com/api/episode/1")!,
                    URL(string: "https://rickandmortyapi.com/api/episode/2")!,
                ],
                url: URL(string: "https://rickandmortyapi.com/api/character/1")!
            ),
            .init(
                id: 2,
                name: "Morty Smith",
                status: .alive,
                species: "Human",
                type: "",
                gender: .male,
                origin: LocationModel(name: "Earth (C-137)", url: "https://rickandmortyapi.com/api/location/1"),
                location: LocationModel(name: "Citadel of Ricks", url: "https://rickandmortyapi.com/api/location/3"),
                image: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg")!,
                episode: [
                    URL(string: "https://rickandmortyapi.com/api/episode/1")!,
                    URL(string: "https://rickandmortyapi.com/api/episode/2")!,
                ],
                url: URL(string: "https://rickandmortyapi.com/api/character/2")!
            )
        ]
    }
}
