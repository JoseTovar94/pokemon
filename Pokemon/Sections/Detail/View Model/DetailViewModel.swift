//
//  DetailViewModel.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation

struct DashboardViewModel {
    var cells = [Cell]()
    
    struct Cell {
        let idState: String?
        let headViewModel: HeadViewModel?
        let abilitiesViewModel: Abilities?
        let moves: Moves?
        let types: Types?
        let general: GeneralDetail?
        let stats: Stats?
        let sprites: [SpritesViewModel]?

        init(idState: String? = nil,
             headViewModel: HeadViewModel? = nil,
             abilitiesViewModel: Abilities? = nil,
             moves: Moves? = nil,
             types: Types? = nil,
             general: GeneralDetail? = nil,
             stats: Stats? = nil,
             sprites: [SpritesViewModel]? = nil) {
            self.idState = idState
            self.headViewModel = headViewModel
            self.abilitiesViewModel = abilitiesViewModel
            self.moves = moves
            self.types = types
            self.general = general
            self.stats = stats
            self.sprites = sprites
        }
    }
    
    struct Abilities {
        let ability: GeneralObj?
        let isHidden: String?
        let slot: String?
    }
    
    struct Moves {
        let move: GeneralObj?
    }
    
    struct Types {
        let slot: String?
        let type: GeneralObj?
    }
    
    struct GeneralDetail {
        let height: String?
        let id: String?
        let baseExperience: String?
        let name: String?
        let weight: String?
    }
    
    struct Stats {
        let baseStat: String?
        let effort: String?
        let stat: GeneralObj?
    }
    struct SpritesViewModel {
        var name: String?
    }
    struct HeadViewModel {
        let text: String?
    }
}
