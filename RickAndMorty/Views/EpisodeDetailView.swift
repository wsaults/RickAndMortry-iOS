//
//  EpisodeDetailView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/29/25.
//

import SwiftUI

struct EpisodeDetailView: View {
    var episode: Episode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(episode.name)
                .font(.largeTitle)
            
            Text(episode.episode)
            
            Text("Aired: \(episode.airDate)")
                .font(.subheadline)
                .padding(.bottom, 20)
            
            Text("Characters:")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(episode.characters, id: \.self) { character in
                        Color.blue
                            .frame(width: 50, height: 50)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    EpisodeDetailView(episode: Episode.mock[0])
}
