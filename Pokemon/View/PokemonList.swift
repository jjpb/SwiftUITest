//
//  PokemonList.swift
//  Pokemon
//
//  Created by Jonathan Punongbayan on 8/10/26.
//

import SwiftUI

struct PokemonList: View {

    @Environment(NavigationStore.self) private var navStore

    @State var viewModel: PokemonListViewModel

    @State private var searchText: String = ""

    @State private var invalidUrl: Bool = false
    
    @State private var invalidResponse: Bool = false

    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(viewModel.pokemon, id: \.id) { pokemon in
                        PokemonListCell(
                            pokemonArtworkURL: pokemon.frontArtwork,
                            pokemonName: pokemon.name
                        )
                        .onAppear {
                            Task {
                                if pokemon == viewModel.pokemon.last {
                                    await fetchPokemon()
                                }
                            }
                        }
                        .onTapGesture {
                            navStore
                                .append(
                                    .details(pokemon)
                                )
                        }
                    }
                } header: {
                    TextField(text: $searchText) {
                        Text("Search Id or Name")
                    }
                    .textFieldStyle(.roundedBorder)
                }
            }
        }
        .task {
            await fetchPokemon()
        }
        .alert("Error", isPresented: $invalidResponse) {
            
        } message: {
            Text("Invalid Response")
        }
    }
    
    private func fetchPokemon() async {
        do {
            try await viewModel.fetchPokemonList()
            
            try await viewModel.fetchPokemon()
        } catch {
            switch error as! APIError {
            case .invalidResponse:
                invalidResponse = true
            }
        }
    }
}

#Preview {
    NavigationView {
        PokemonList(
            viewModel: PokemonListViewModel()
        )
        .environment(NavigationStore())
    }
}
