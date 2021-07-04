//
//  Enumeration.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation
import Alamofire

enum APIErrorEnum: String {
    case expiredOrMissingToken = "121"
}

enum ParamsEncoder: String {
    case json, url, multipart
    func toParameterEncoder() -> ParameterEncoder {
        switch self {
        case .json: return JSONParameterEncoder.default
        case .url: return URLEncodedFormParameterEncoder.default
        case .multipart: return URLEncodedFormParameterEncoder.default
        }
    }
}
enum CategoryHomeDashBoard: String {
    case head = "Head"
    case abilities  = "Abilities"
    case moves  = "Moves"
    case types  = "Types"
    case general = "General"
    case stats = "Stats"
    case sprites = "Sprites"

}
