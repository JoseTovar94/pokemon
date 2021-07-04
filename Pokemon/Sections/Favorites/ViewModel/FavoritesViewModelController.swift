//
//  FavoritesViewModelController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 3/07/21.
//

import Foundation
import UIKit
import RealmSwift

class FavoritesViewModelController {
    
    // MARK: - Vars
    private var view: FavoriteProtocol?
    let realm = try! Realm()
    let save = LikeModel()
    var array: [String] = []
    
    
    // MARK: - Life cycle
    func attach(view: FavoriteProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        readImage()
    }
    
    func readImage() {
        let data = realm.objects(LikeModel.self)
        for item in data {
            array.append(contentsOf: item.image)
        }
        self.view?.reloadUI()
    }
}
