//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Jonathan Punongbayan on 8/17/26.
//

import SwiftUI

struct PokemonDetail: View {
    
    @Environment(NavigationStore.self) private var navStore

    let pokemon: PokemonModel

    var body: some View {
        ScrollView {
            VStack (alignment: .center) {
                AsyncImage(
                    url: pokemon.frontArtwork) { image in
                        
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                    }
                    .frame(height: 300)
                
                Text(pokemon.name.capitalized)
                    
                    .font(
                        .system(
                            .largeTitle,
                            weight: .bold)
                        )
            }
            
            Spacer()
            
            VStack {
                HStack {
                    Text("Height")
                    Text("\(pokemon.height)")
                }
                
                HStack {
                    Text("Weight")
                    Text("\(pokemon.weight)")
                }
            }
        }
    }
}

#Preview {
    PokemonDetail(
        pokemon: PreviewMockData.pokemon
    )
    .environment(NavigationStore())
}
