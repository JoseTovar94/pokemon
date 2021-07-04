//
//  DetailModel.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation
struct DetailModel: Codable {
    let abilities: [Abilities]?
    let baseExperience: Int?
    let gameIndices: [GameIndices]?
    let height: Int?
    let id: Int?
    let moves: [Moves]?
    let name: String?
    let species: GeneralObj?
    let sprites: Sprites?
    let stats: [Stats]?
    let types: [Types]?
    let weight: Int?

    
    enum CodingKeys: String, CodingKey {
        case abilities, height, id, moves, name,species, sprites, stats, types, weight
        case baseExperience = "base_experience"
        case gameIndices = "game_indices"
    }
    

}
struct Abilities: Codable {
    let ability: GeneralObj?
    let isHidden: Bool?
    let slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability, slot
        case isHidden = "is_hidden"
    }
    
}
struct GameIndices: Codable {
    let gameIndex: Int?
    let version: GeneralObj?

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case version
    }
}
struct Moves: Codable {
    let move: GeneralObj?
}
struct Sprites: Codable {
    let backDefault: String?
    let backShiny: String?
    let frontDefault: String?
    let frontShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
struct Stats: Codable {
    let baseStat: Int?
    let effort: Int?
    let stat: GeneralObj?
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}
struct Types: Codable {
    let slot: Int?
    let type: GeneralObj?
}
struct GeneralObj: Codable {
    let name: String?
    let url: String?
}
