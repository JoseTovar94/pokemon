//
//  HomeViewModelController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//
import Foundation
import UIKit

class HomeViewModelController {
    
    // MARK: - Vars
    private var view: HomeProtocol?
    var viewModel: HomeViewModel?
    var resultsPokemon: [PokemonResult]? = []
    var totalPages = 0
    
    // MARK: - Life cycle
    func attach(view: HomeProtocol) {
        self.view = view
    }

    // MARK: Public
    func viewDidLoad() {
        loadResult()
    }
    
    // MARK: Private
    private func loadResult(textSearch: String = "") {
        let apiRoute = APIRoute<APIRequestParams.Home>.Home()
        apiRoute.params = .init(offset: String(totalPages))

        UIApplication.showHUD()
        APINetworking.request(route: apiRoute) { (response: HomeModel) in
            
            self.resultsPokemon! += response.results ?? []
            let result = HomeViewModel.init(next: response.next, previous: response.previous, results:  self.resultsPokemon)
          
            self.viewModel = result
            self.view?.reloadUI()
            UIApplication.dismissHUD()
            
        }onError: { (error) in
            print("Error")
            UIApplication.dismissHUD()
        }
    }
    
    func resultsAtIndex(_ index: Int) -> PokemonResult? {
        
        guard self.viewModel?.results?.indices.contains(index) == true else { return nil }
        
        if (self.viewModel?.results?.count ?? 0) < index + 2 {
            loadMore()
        }
        
        return self.viewModel?.results?[index]
    }
    
    func loadMore() {
        if (self.viewModel?.next) != nil {
            totalPages += 20
            loadResult()
        }
    }
    
}




