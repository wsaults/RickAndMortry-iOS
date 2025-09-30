//
//  LocationFetching.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/30/25.
//

import Foundation

protocol LocationFetching {
    func fetchLocations() async throws(NetworkError) -> [ShowLocation]
}

class LocationService: LocationFetching {
    private var pageInfo: PageInfo?
    let requestURL = URL(string: "https://rickandmortyapi.com/api/location")!
    
    func fetchLocations() async throws(NetworkError) -> [ShowLocation] {
        var url = requestURL
        if let info = pageInfo {
            if let next = pageInfo?.next {
                url = next
            } else {
                return []
            }
        }
        
        let request = URLRequest(url: url)
        let response: (Data, URLResponse)
        do {
            response = try await URLSession.shared.data(for: request)
        } catch {
            throw .badRequest
        }
        
        let locations: [ShowLocation]
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(ShowLocationResponse.self, from: response.0)
            locations = result.results
            pageInfo = result.info
        } catch {
            throw .jsonDecoding
        }
        
        return locations
    }
}

class MockLocationService: LocationFetching {
    let locations: [ShowLocation]
    
    init(locations: [ShowLocation]) {
        self.locations = locations
    }
    
    func fetchLocations() async throws(NetworkError) -> [ShowLocation] {
        locations
    }
}
