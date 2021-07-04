//
//  HomeModel.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation

struct HomeModel: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonResult]?
}
struct PokemonResult: Codable {
    let name: String?
    let url: String?
    let id: String?
}
