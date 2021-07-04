//
//  Catalogs.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation
import UIKit

enum StoryboardCatalog: String {
    case Splash
    case Home
    case Detail
    case Like
    case Favorites

    func createInstance() -> UIStoryboard {
        return UIStoryboard(name: String(describing: self), bundle: nil)
    }
}
enum TableViewCellCatalog: String {
    case HomeTableViewCell
    case DetailTableViewCell
    case GeneralTableViewCell
    case TypesMovesTableViewCell
    case TitleTableViewCell
    case SpritesTableViewCell
    case FavoritesTableViewCell
}
enum CellReuseIdentifierAll: String {
    case HomeTableViewCell
    case DetailCell
    case TypesCell
    case GeneralTableViewCell
    case TitleCell
    case SpritesTableViewCell
    case FavoritesCell
}

enum ViewControllerCatalog: RawRepresentable {
    case Splash
    case Home
    case HomeNavigation
    case Detail
    case Like
    case Favorites
    
    var rawValue: (class: AnyClass, storyboard: StoryboardCatalog) {
        switch self {
        case .Splash:                  return (SplashViewController.self, .Splash)
        case .Home:                    return (HomeViewController.self, .Home)
        case .HomeNavigation:          return (HomeNavigationController.self, .Home)
        case .Detail:                  return (DetailViewController.self, .Detail)
        case .Like:                    return (LikeViewController.self, .Like)
        case .Favorites:               return (FavoritesViewController.self, .Favorites)

        }
    }
    
}
extension ViewControllerCatalog: CaseIterable {
    init?(rawValue: (class: AnyClass, storyboard: StoryboardCatalog)) {
        return nil
    }
    
    init?(name: String) {
        for item in ViewControllerCatalog.allCases where String(describing: item) == name {
            self = item
            return
        }
        return nil
    }
    
    var className: String {
        return String(describing: self.rawValue.class)
    }
    
    var name: String {
        return String(describing: self)
    }
    
    func createInstance() -> UIViewController? {
        let sb = self.rawValue.storyboard.createInstance()
        let vc = sb.instantiateViewController(withIdentifier: String(describing: self.rawValue.class))
        return vc
    }
}
