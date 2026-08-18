//
//  PokemonListNavStack.swift
//  Pokemon
//
//  Created by Jonathan Punongbayan on 8/17/26.
//

import SwiftUI

struct PokemonListNavStack: View {
    @State private var navStore = NavigationStore()

    var body: some View {
        @Bindable var navStore = navStore
    
        NavigationStack(path: $navStore.path) {
            PokemonList(
                viewModel:
                    PokemonListViewModel()
            )
            .navigationDestination(for: NavigationRoute.self) { route in
                switch route {
                case .details(let pokemon):
                    PokemonDetail(pokemon: pokemon)
                        .environment(navStore)
                }
            }
            .environment(navStore)
        }
    }
}
