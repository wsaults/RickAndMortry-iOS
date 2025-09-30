//
//  LocationDetailView.swift
//  RickAndMorty
//
//  Created by Will Saults on 9/30/25.
//

import SwiftUI

struct LocationDetailView: View {
    let location: ShowLocation
    
    var body: some View {
        Text(location.name)
    }
}

#Preview {
    LocationDetailView(location: ShowLocation.mock[0])
}
