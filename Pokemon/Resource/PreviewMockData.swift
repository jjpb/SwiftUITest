//
//  PreviewMockData.swift
//  Pokemon
//
//  Created by Jonathan Punongbayan on 8/17/26.
//

import Foundation

struct PreviewMockData {
    static var pokemon: PokemonModel = {
        let pokemonRawJSON = """
        {
            "name": "test Pokemon",
            "id": 35,
            "height": 100,
            "weight": 75,
            "sprites": {
                "other": {
                    "official-artwork": {
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/35.png"
                    }
                }
            }
        }
        """.data(using: .utf8)!
        
        return try! JSONDecoder().decode(PokemonModel.self, from: pokemonRawJSON)
    }()
}
