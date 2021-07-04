//
//  MockedAPI.swift
//  PokemonTests
//
//  Created by Jose Luis Tovar Jimenez on 2/07/21.
//

import Foundation
import XCTest
import Swifter

fileprivate class GenericTests: XCTestCase {}

struct MockedAPI {
    static let server = HttpServer()

    static func startServer() {
        server["/hello"] = { .ok(.htmlBody("You asked for \($0)"))  }
        
        try? server.start(9080, forceIPv4: true)

        print("Server has started (port = \((try? server.port()) ?? 0). Try to connect now...")
    }
    
    static func getJSON(from jsonFile: String) -> [String: Any] {
        guard let pathString = Bundle(for: GenericTests.self).path(forResource: jsonFile, ofType: "json") else {
            fatalError("Oauth.json not found")
        }

        guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to String")
        }

        print("The JSON string is: \(jsonString)")

        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to convert UnitTestData.json to Data")
        }

        guard let jsonDictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:Any] else {
            fatalError("Unable to convert UnitTestData.json to JSON dictionary")
        }

        print("The JSON dictionary is: \(jsonDictionary)")
        
        return jsonDictionary
    }
    
    static func addSuccess(_ endpoint: String, jsonFile: MockedJSONSuccess) {
        server[endpoint] = { request in
            return .ok(.json(getJSON(from: jsonFile.rawValue)))
        }
    }
    
    static func addError(_ endpoint: String, jsonFile: MockedJSONError) {
        server[endpoint] = { request in
            return .badRequest(.json(getJSON(from: jsonFile.rawValue)))
        }
    }
}

enum MockedJSONSuccess: String {
    case home
    case Detail
}

enum MockedJSONError: String {
    case DetailNotExists
    case oauthErrorWrongCredentials
}
