//
//  UIViewController+Extension.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 4/07/21.
//

import UIKit
extension UIViewController {
    func newInstanceOfView(nextPage: String, parametershowView: String? = nil) -> UIViewController? {
        if let vcFromCatalog = ViewControllerCatalog(name: nextPage),
           let vc = vcFromCatalog.createInstance() {
            switch vcFromCatalog {
            case .Detail:
                let castedVC = vc as? DetailViewController
                castedVC?.idPokemon = parametershowView ?? ""
                return castedVC
            default: break
            }
            
            return vc
        }
        return nil
    }
}
