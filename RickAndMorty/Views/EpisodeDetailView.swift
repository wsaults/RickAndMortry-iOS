//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import SwiftUI

struct EpisodeDetailView: View {
    var viewModel: EpisodeViewModel
    var episode: Episode
    @State private var characterMap = [String: ShowCharacter]()
    var columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 8) {
                Text(episode.name)
                    .font(.largeTitle)
                
                Text(episode.episode)
                
                Text("Aired: \(episode.airDate)")
                    .font(.subheadline)
                    .padding(.bottom, 20)
                
                
                Text("Characters:")
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(episode.characters, id: \.self) { characterUrl in
                        VStack {
                            if let character = characterMap[characterUrl.absoluteString] {
                                NavigationLink(value: character) {
                                    VStack {
                                        AsyncImage(url: character.image) { image in
                                            image
                                                .resizable()
                                                .frame(width: 40, height: 40)
                                        } placeholder: {
                                            Color.gray
                                                .opacity(0.20)
                                                .frame(width: 40, height: 40)
                                        }
                                        Text(character.name)
                                            .font(.caption)
                                            .foregroundStyle(.black)
                                    }
                                }
                            }
                        }
                        .task {
                            let character = await viewModel.fetchCharacter(from: characterUrl)
                            characterMap[characterUrl.absoluteString] = character
                        }
                    }
                    Spacer()
                }
            }
        }
        .navigationDestination(for: ShowCharacter.self, destination: { character in
            CharacterDetailView(character: character)
        })
        .padding()
    }
}

#Preview {
    EpisodeDetailView(
        viewModel: EpisodeViewModel(
            episodeService: MockEpisodeService(episodes: Episode.mock),
            characterService: MockCharacterService(characters: ShowCharacter.mock)
        ),
        episode: Episode.mock[0]
    )
}
