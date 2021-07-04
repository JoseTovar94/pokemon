//
//  LogHelper.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation
class LogHelper {
    static let shared = LogHelper()
    
    func logErrorPrint(error: Error) {
        #if DEBUG
        print(error)
        #else
        _ = "Produccion"
        #endif
    }
    
    func logErrorStringPrint(errorString: String) {
        #if DEBUG
        print(errorString)
        #else
        _ = "Produccion"
        #endif
    }
    
    static func log(request: URLRequest) {
        #if DEBUG
        print("\n\n--------------- API REQUEST ---------------")
        print("METHOD:\n\t \(request.method?.rawValue ?? "")")
        print("URL:\n\t \(request.url?.absoluteString ?? "")")
        print("HEADERS:\n\t\(request.headers)")
        if let data = request.httpBody {
            let jsonString = String(data: data, encoding: .utf8) ?? ""
            if let jsonData = jsonString.data(using: .utf8),
               let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers),
               let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) {
                print("BODY:")
                for line in prettyPrintedJson.lines {
                    print("\t\(line)")
                }
            } else {
                print("BODY:\n\t \(jsonString)")
            }
        }
        print("-----------------------------------------\n\n")
        #endif
    }
    
    static func log<T>(response: Any? = nil, error: Error? = nil, request: URLRequest, type: T) {
        #if DEBUG
        print("\n\n--------------- API RESPONSE ---------------")
        print("METHOD:\n\t \(request.method?.rawValue ?? "")")
        print("URL:\n\t \(request.url?.absoluteString ?? "")")
        
        if let error = error {
            print("ERROR (\(error.code ?? "Unknown code"):\n\t\(error.localizedDescription)")
        }
        if let response = response,
           let prettyJsonData = try? JSONSerialization.data(withJSONObject: response, options: .prettyPrinted),
           let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) {
            print("RESPONSE (\(String(describing: T.self))):")
            for line in prettyPrintedJson.lines {
                print("\t\(line)")
            }
        }
        print("-----------------------------------------\n\n")
        #endif
    }
}
