//
//  PokemonListModel.swift
//  Pokemon
//
//  Created by Jonathan Punongbayan on 8/12/26.
//

import Foundation

struct PokemonListModel: Decodable {

    let next: String
    let previous: String?
    let count: Int
    let results: [PokemonListResult]

    enum CodingKeys: String, CodingKey {
        case next
        case previous
        case results
        case count
    }

    enum ResultKeys: String, CodingKey {
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder
            .container(
                keyedBy: CodingKeys.self
            )
            
        self.next = try container.decode(String.self, forKey: .next)
        self.previous = try container.decode(String?.self, forKey: .previous)
        self.count = try container.decode(Int.self, forKey: .count)
        
        self.results = try container
            .decodeIfPresent(
                [PokemonListResult].self,
                forKey: .results
            ) ?? []
    }
}

struct PokemonListResult: Decodable {
    let name: String
    let url: String
}
