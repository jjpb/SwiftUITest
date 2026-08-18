//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Jonathan Punongbayan on 8/12/26.
//

import Foundation
import Observation

@Observable
class PokemonListViewModel {
    
    var pokemonList: PokemonListModel?
    var pokemon: [PokemonModel] = []
    
    var isLoading = false
    
    var url = "https://pokeapi.co/api/v2/pokemon/?limit=10"
    
    func fetchPokemonList() async throws {
        guard !isLoading else {
            return
        }
    
        self.isLoading = true
    
        do {
            let url = URL(string: url)!
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodeData = try JSONDecoder().decode(PokemonListModel.self, from: data)
            
            await MainActor.run {
                self.pokemonList = decodeData
            }
        } catch {
            throw APIError.invalidResponse
        }
        
        self.isLoading = false
    }
    
    func fetchPokemon() async throws  {
        guard !isLoading else {
            return
        }
    
        self.isLoading = true
    
        do {
            guard let pokemonList = pokemonList else {
                return
            }
            
            for pokemonResult in pokemonList.results {
                let url = URL(string: pokemonResult.url)!
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodeData = try JSONDecoder().decode(PokemonModel.self, from: data)
                
                await MainActor.run {
                    self.pokemon.append(decodeData)
                }
            }
            
            self.url = pokemonList.next
        } catch {
            throw APIError.invalidResponse
        }
        
        self.isLoading = false
    }
}

enum APIError: Error, LocalizedError {
    case invalidResponse
}
