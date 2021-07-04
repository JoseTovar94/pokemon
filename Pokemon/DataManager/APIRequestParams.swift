//
//  APIRequestParams.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation

struct APIRequestParams {
    
    struct Home: Codable {
        var offset: String
    }
    
    struct Detail: Codable {
        var id: String
        private enum CodingKeys: String, CodingKey {
            case id = ""
        }
    }
}
