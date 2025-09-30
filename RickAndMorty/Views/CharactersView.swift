//
//  CharactersView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import SwiftUI

struct CharactersView: View {
    @State private var viewModel: CharactersViewModel
    
    init(viewModel: CharactersViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    if viewModel.isLoading, viewModel.characters.isEmpty {
                        ForEach(0..<5, id: \.self) { _ in
                            CharacterRowPlaceholder()
                                .redacted(reason: .placeholder)
                        }
                    } else {
                        ForEach(viewModel.characters) { character in
                            NavigationLink(value: character) {
                                CharacterRow(character: character)
                            }
                            .onAppear {
                                Task {
                                    if character.id == viewModel.characters.last?.id {
                                        await viewModel.fetchCharacters()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .task { await viewModel.fetchCharacters() }
            .navigationTitle("Characters")
            .navigationDestination(for: Character.self) { character in
                // TODO: detail view
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            }
        }
    }
}

struct CharacterRow: View {
    let character: ShowCharacter
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.headline)
            
            Text("Status: \(character.status.rawValue)")
            
            Text("Species: \(character.species)")
            
            Text("Origin: \(character.origin.name)")
        }
    }
}

struct CharacterRowPlaceholder: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Character Name")
                .font(.headline)
            
            Text("Status: Alive")
            
            Text("Species: Human")
            
            Text("Origin: Earth")
        }
    }
}

#Preview {
    CharactersView(
        viewModel: CharactersViewModel(
            characterService: MockCharacterService(characters: ShowCharacter.mock)
        )
    )
}
