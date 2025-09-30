//
//  ShowLocation.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/30/25.
//

import Foundation

struct ShowLocationResponse: Decodable {
    let info: PageInfo
    let results: [ShowLocation]
}

struct ShowLocation: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    
    static var mock: [ShowLocation] {
        [
            .init(
                id: 1,
                name: "Earth",
                type: "Planet",
                dimension: "Dimension C-137",
                residents: [
                    "https://rickandmortyapi.com/api/character/38",
                    "https://rickandmortyapi.com/api/character/45",
                ],
                url: "https://rickandmortyapi.com/api/location/1"
            ),
            .init(
                id: 2,
                name: "Abadango",
                type: "Cluster",
                dimension: "unknown",
                residents: [
                    "https://rickandmortyapi.com/api/character/6"
                ],
                url: "https://rickandmortyapi.com/api/location/2"
            )
        ]
    }
}
