//
//  Constants.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation


struct Constants {
    struct Request {
        
        // MARK: Base
        #if DEVELOPMENT
        static var apiBaseURL = "https://pokeapi.co"
        #else
        static var apiBaseURL = "https://pokeapi.co"
        #endif
        
        // MARK: url
        static let home = "/api/v2/pokemon"
        static let detail = "/api/v2/pokemon/"
        static let baseImage = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/"
    }
    
    struct AppFonts {
        static let regular = "DMSans-Regular"
        static let bold = "DMSans-Bold"
        static let italic = "DMSans-Italic"
        static let medium = "DMSans-Medium"
    }
}
