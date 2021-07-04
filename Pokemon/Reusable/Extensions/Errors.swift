//
//  Errors.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation

struct ErrorUserInfoKey {
    static let title = "NSLocalizedTitleKey"
    static let code = "NSLocalizedCodeKey"
    static let message = "NSLocalizedMessageKey"
    static let detail = NSLocalizedDescriptionKey
}


extension NSError {
    static var unknownError: Error {
        let userInfo = [
            ErrorUserInfoKey.code: "UNKNOWN",
            ErrorUserInfoKey.message: "UNKNOWN ERROR",
            ErrorUserInfoKey.title: "Error desconocido",
            ErrorUserInfoKey.detail: "Por favor intente nuevamente. Si el problema persiste, contacte a soporte técnico."
        ]
        
        let error = NSError(
            domain: "com.josetovar.pokemon",
            code: 0,
            userInfo: userInfo
        )
        
        return error
    }
     
    static func initWith(code: String? = nil, message: String? = nil, title: String? = nil, detail: String? = nil) -> Error {
        let userInfo = [
            ErrorUserInfoKey.code: code ?? "UNKNOWN",
            ErrorUserInfoKey.message: message ?? "UNKNOWN ERROR",
            ErrorUserInfoKey.title: title ?? "Error desconocido",
            ErrorUserInfoKey.detail: detail ?? "Por favor intente nuevamente. Si el problema persiste, contacte a soporte técnico."
        ]
        
        let error = NSError(
            domain: "com.josetovar.pokemon",
            code: 0,
            userInfo: userInfo
        )
        
        return error
    }
}

extension Error {

    var title: String? {
        return getProperty(ErrorUserInfoKey.title)
    }
    
    var detail: String? {
        return getProperty(ErrorUserInfoKey.detail)
    }
    
    var code: String? {
        return getProperty(ErrorUserInfoKey.code)
    }
    
    var message: String? {
        return getProperty(ErrorUserInfoKey.message)
    }
    
    private func getProperty(_ property: String) -> String? {
        if let nsError = self as NSError? {
            return nsError.userInfo[property] as? String
        }
        return nil
    }
}
