//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/30/25.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: ShowCharacter
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: character.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                } placeholder: {
                    Color.gray
                        .opacity(0.20)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                }
                
                Text(character.status.rawValue)
                Text(character.species)
                Text(character.type)
                Text(character.gender.rawValue)
                
                Text(character.origin.name)
                
                Text("Episodes:")
                    .font(.headline)
                ForEach(character.episode, id: \.self) { episode in
                    Text(episode.absoluteString)
                }
            }
            .navigationTitle(character.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    CharacterDetailView(character: ShowCharacter.mock[0])
}
