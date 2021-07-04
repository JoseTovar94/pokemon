//
//  LikeViewModelController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 3/07/21.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

class LikeViewModelController {
    
    // MARK: - Vars
    private var view: LikeProtocol?
    let realm = try! Realm()
    
    // MARK: - Life cycle
    func attach(view: LikeProtocol) {
        self.view = view
    }
    
    func saveImage(urlImage: String) {
        let save = LikeModel()
        save.image.append(urlImage)
        try! realm.write {
            realm.add(save)
        }
    }
}




