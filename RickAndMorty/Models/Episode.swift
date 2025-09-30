//
//  Episode.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import Foundation

struct EpisodesResult: Decodable {
    let info: PageInfo
    let results: [Episode]
}

struct Episode: Identifiable, Decodable, Hashable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [URL]
    let url: URL
    
    static var mock: [Episode] {
        [
            .init(
                id: 1,
                name: "Pilot",
                airDate: "December 2, 2013",
                episode: "S01E01",
                characters: [
                    URL(string: "https://rickandmortyapi.com/api/character/1")!,
                    URL(string: "https://rickandmortyapi.com/api/character/2")!,
                    URL(string: "https://rickandmortyapi.com/api/character/35")!,
                    URL(string: "https://rickandmortyapi.com/api/character/38")!,
                    URL(string: "https://rickandmortyapi.com/api/character/62")!,
                    URL(string: "https://rickandmortyapi.com/api/character/92")!,
                    URL(string: "https://rickandmortyapi.com/api/character/127")!,
                    URL(string: "https://rickandmortyapi.com/api/character/144")!,
                    URL(string: "https://rickandmortyapi.com/api/character/158")!,
                    URL(string: "https://rickandmortyapi.com/api/character/175")!,
                    URL(string: "https://rickandmortyapi.com/api/character/179")!,
                    URL(string: "https://rickandmortyapi.com/api/character/181")!,
                    URL(string: "https://rickandmortyapi.com/api/character/239")!,
                    URL(string: "https://rickandmortyapi.com/api/character/249")!,
                    URL(string: "https://rickandmortyapi.com/api/character/271")!,
                    URL(string: "https://rickandmortyapi.com/api/character/338")!,
                    URL(string: "https://rickandmortyapi.com/api/character/394")!,
                    URL(string: "https://rickandmortyapi.com/api/character/395")!,
                    URL(string: "https://rickandmortyapi.com/api/character/435")!
                    ],
                url: URL(string: "https://rickandmortyapi.com/api/episode/1")!
            ),
            .init(
                id: 2,
                name: "Lawnmower Dog",
                airDate: "December 9, 2013",
                episode: "S01E02",
                characters: [
                    URL(string: "https://rickandmortyapi.com/api/character/1")!,
                    URL(string: "https://rickandmortyapi.com/api/character/2")!,
                    URL(string: "https://rickandmortyapi.com/api/character/35")!,
                    URL(string: "https://rickandmortyapi.com/api/character/38")!,
                    URL(string: "https://rickandmortyapi.com/api/character/62")!,
                    URL(string: "https://rickandmortyapi.com/api/character/92")!,
                    URL(string: "https://rickandmortyapi.com/api/character/127")!,
                    URL(string: "https://rickandmortyapi.com/api/character/144")!,
                    URL(string: "https://rickandmortyapi.com/api/character/158")!,
                    URL(string: "https://rickandmortyapi.com/api/character/175")!,
                    URL(string: "https://rickandmortyapi.com/api/character/179")!,
                    URL(string: "https://rickandmortyapi.com/api/character/181")!,
                    URL(string: "https://rickandmortyapi.com/api/character/239")!,
                    URL(string: "https://rickandmortyapi.com/api/character/249")!,
                    URL(string: "https://rickandmortyapi.com/api/character/271")!,
                    URL(string: "https://rickandmortyapi.com/api/character/338")!,
                    URL(string: "https://rickandmortyapi.com/api/character/394")!,
                    URL(string: "https://rickandmortyapi.com/api/character/395")!,
                    URL(string: "https://rickandmortyapi.com/api/character/435")!
                    ],
                url: URL(string: "https://rickandmortyapi.com/api/episode/2")!
            )
        ]
    }
}

//id: 1,
//name: "Pilot",
//air_date: "December 2, 2013",
//episode: "S01E01",
//characters: [
//"https://rickandmortyapi.com/api/character/1",
//],
//url: "https://rickandmortyapi.com/api/episode/1",
//created: "2017-11-10T12:56:33.798Z"
