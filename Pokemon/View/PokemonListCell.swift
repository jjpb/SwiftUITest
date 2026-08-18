//
//  PokemonListCell.swift
//  Pokemon
//
//  Created by Jonathan Punongbayan on 8/11/26.
//

import SwiftUI

struct PokemonListCell: View {

    let pokemonArtworkURL: URL
    let pokemonName: String

    var body: some View {
        HStack {
            VStack {
                AsyncImage(
                    url: pokemonArtworkURL) { image in
                    
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                }
            }
            
            VStack {
                Text(pokemonName.capitalized)
            }
        }
        .frame(
            height: 80
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 8
            )
        )
    }
}


#Preview {
    PokemonListCell(
        pokemonArtworkURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/35.png")!,
        pokemonName: "test"
    )
}
