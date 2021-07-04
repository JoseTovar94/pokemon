//
//  BaseViewController.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 3/07/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    func setNextView(nextPage: String, parametershowView: String? = nil, presentView: Bool? = nil, animated: Bool = true) {
        if let emptyVC = newInstanceOfView(nextPage: nextPage, parametershowView: parametershowView) {
            if presentView ?? false {
                emptyVC.modalPresentationStyle = .fullScreen
                self.navigationController?.present(emptyVC, animated: animated)
            } else {
                self.navigationController?.pushViewController(emptyVC, animated: animated)
            }
        } else if nextPage == "0" {
            self.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func setNextView(nextPage: ViewControllerCatalog, parametershowView: String? = nil, presentView: Bool? = nil, animated: Bool = true) {
        setNextView(nextPage: nextPage.name, parametershowView: parametershowView, presentView: presentView, animated: animated)
    }
    
}
