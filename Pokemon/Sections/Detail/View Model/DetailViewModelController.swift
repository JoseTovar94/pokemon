//
//  DetailViewModelController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation
import UIKit

class DetailViewModelController {
    
    // MARK: - Vars
    private var view: DetailProtocol?
    var viewModel = DashboardViewModel()
    var idPokemon = ""
    
    // MARK: - Life cycle
    func attach(view: DetailProtocol) {
        self.view = view
    }
    
    func viewDidLoad(id: String) {
        idPokemon = id
        loadResult()
    }
    
    // MARK: - Private
    private func loadResult() {
        let apiRoute = APIRoute<APIRequestParams.Detail>.Detail()
        apiRoute.url = Constants.Request.apiBaseURL + Constants.Request.detail + idPokemon
        
        UIApplication.showHUD()
        APINetworking.request(route: apiRoute) { (response: DetailModel) in
            self.viewModel.cells = []
    
            self.viewModel.cells.append(.init(idState: "Head", headViewModel: .init(text: "General")))
            self.viewModel.cells.append(.init(idState: "General", general: self.loadGeneralViewModel(response)))
            
            if (response.abilities?.count ?? 0) > 0 {
                self.viewModel.cells.append(.init(idState: "Head", headViewModel: .init(text: "Abilities")))
                for index in 0..<(response.abilities?.count ?? 0) {
                    let abilitiesViewModel = self.loadAbilitiesviewModel(response, indexPath: index)
                    self.viewModel.cells.append(.init(idState: "Abilities", abilitiesViewModel: abilitiesViewModel))
                }
            }
            
            if (response.moves?.count ?? 0) > 0 {
                self.viewModel.cells.append(.init(idState: "Head", headViewModel: .init(text: "Moves")))
                for index in 0..<(response.moves?.count ?? 0) {
                    let movesViewModel = self.loadMovesViewModel(response, indexPath: index)
                    self.viewModel.cells.append(.init(idState: "Moves", moves: movesViewModel))
                }
            }
            
            if (response.types?.count ?? 0) > 0 {
                self.viewModel.cells.append(.init(idState: "Head", headViewModel: .init(text: "Types")))
                for index in 0..<(response.types?.count ?? 0) {
                    let typesViewModel = self.loadTypesViewModel(response, indexPath: index)
                    self.viewModel.cells.append(.init(idState: "Types", types: typesViewModel))
                }
            }
            
            if (response.stats?.count ?? 0) > 0 {
                self.viewModel.cells.append(.init(idState: "Head", headViewModel: .init(text: "Stats")))
                for index in 0..<(response.stats?.count ?? 0) {
                    let statsViewModel = self.loadStatsViewModel(response, indexPath: index)
                    self.viewModel.cells.append(.init(idState: "Stats", stats: statsViewModel))
                }
            }
            
            if response.sprites != nil {
                let spritesViewModel = self.loadSpritesViewModel(response)
                self.viewModel.cells.append(.init(idState: "Sprites", sprites: spritesViewModel))
            }
            
            self.view?.reloadUI()
            UIApplication.dismissHUD()
            
        }onError: { (error) in
            print("Error")
            UIApplication.dismissHUD()
        }
    }
    
    private func loadAbilitiesviewModel(_ propertyAbilities: DetailModel?, indexPath: Int?) -> DashboardViewModel.Abilities {
        let ability = propertyAbilities?.abilities?[indexPath ?? 0].ability
        let isHidden = String(propertyAbilities?.abilities?[indexPath ?? 0].isHidden ?? false)
        let slot = String(propertyAbilities?.abilities?[indexPath ?? 0].slot ?? 0)
        
        return .init(ability: ability, isHidden: isHidden, slot: slot)
    }
    
    private func loadMovesViewModel(_ propertyMoves: DetailModel?, indexPath: Int?) -> DashboardViewModel.Moves {
        let obj = GeneralObj(name: propertyMoves?.moves?[indexPath ?? 0].move?.name, url: propertyMoves?.moves?[indexPath ?? 0].move?.url)
        
        return .init(move: obj)
    }
    
    private func loadTypesViewModel(_ propertyType: DetailModel?, indexPath: Int?) -> DashboardViewModel.Types {
        
        let obj = GeneralObj(name: propertyType?.types?[indexPath ?? 0].type?.name, url: propertyType?.types?[indexPath ?? 0].type?.url)
        
        return .init(slot: String(propertyType?.types?[indexPath ?? 0].slot ?? 0), type: obj)
    }
    
    private func loadGeneralViewModel(_ propertyGeneral: DetailModel?) -> DashboardViewModel.GeneralDetail {
        let height = String(propertyGeneral?.height ?? 0)
        let id = String(propertyGeneral?.id ?? 0)
        let baseExperience = String(propertyGeneral?.baseExperience ?? 0)
        let weight = String(propertyGeneral?.weight ?? 0)
        
        return .init(
            height: height,
            id: id,
            baseExperience: baseExperience,
            name: propertyGeneral?.name,
            weight: weight)
    }
    
    private func loadStatsViewModel(_ propertyStats: DetailModel?, indexPath: Int?) -> DashboardViewModel.Stats {
        
        let obj = GeneralObj(name: propertyStats?.stats?[indexPath ?? 0].stat?.name, url: propertyStats?.stats?[indexPath ?? 0].stat?.url)
        let baseStat = String(propertyStats?.stats?[indexPath ?? 0].baseStat ?? 0)
        let effort = String(propertyStats?.stats?[indexPath ?? 0].effort ?? 0)

        return .init(baseStat: baseStat, effort: effort, stat: obj)
    }
    
    private func loadSpritesViewModel(_ propertySprites: DetailModel?) -> [DashboardViewModel.SpritesViewModel] {
        var sprites = [DashboardViewModel.SpritesViewModel]()
        sprites.append(.init(name: propertySprites?.sprites?.frontDefault))
        sprites.append(.init(name: propertySprites?.sprites?.backDefault))
        sprites.append(.init(name: propertySprites?.sprites?.frontShiny))
        sprites.append(.init(name: propertySprites?.sprites?.backShiny))
        
        return .init(sprites)
    }
}
