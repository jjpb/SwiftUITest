//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Jonathan Punongbayan on 8/11/26.
//

import Foundation

struct PokemonModel: Decodable, Identifiable, Hashable {
    let name: String
    let id: Int
    let frontArtwork: URL
    let height: Int
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case sprites
        case height
        case weight
    }
    
    enum SpriteOtherCodingKeys: String, CodingKey {
        case other
    }
    
    enum OfficialArtworkCodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
    
    enum FrontCodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.id = try container.decode(Int.self, forKey: .id)
        self.height = try container.decode(Int.self, forKey: .height)
        self.weight = try container.decode(Int.self, forKey: .weight)
        
        let spriteContainer = try container.nestedContainer(keyedBy: SpriteOtherCodingKeys.self, forKey: .sprites)
        let otherContainer = try spriteContainer.nestedContainer(keyedBy: OfficialArtworkCodingKeys.self, forKey: .other)
        let artworkContainer = try otherContainer.nestedContainer(keyedBy: FrontCodingKeys.self, forKey: .officialArtwork)
        
        self.frontArtwork = try artworkContainer.decode(URL.self, forKey: .frontDefault)
    }
}
