//
//  APIRouter.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation
import Alamofire

extension String: ParameterEncoding {
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
    
}

class APIRoute<Params: Encodable> {
    var method: HTTPMethod = .get
    var url = ""
    var params: Params?
    var encoder: ParamsEncoder = .json
    var headers = [String: String]()
    var isProtected = true
    
    func asURLRequest() throws -> URLRequest {
        let url = try self.url.asURL()
        var headers = self.headers
       
        let request = try URLRequest(url: url, method: method, headers: HTTPHeaders(headers))
        
        if encoder != .multipart {
            return try encoder.toParameterEncoder().encode(params, into: request)
        } else {
            return request
        }
    }
}
extension APIRoute {
    class Home: APIRoute {
        override init() {
            super.init()
            method = .get
            encoder = .url
            url = Constants.Request.apiBaseURL + Constants.Request.home
        }
    }
    
    class Detail: APIRoute {
        override init() {
            super.init()
            method = .get
            encoder = .url
            url = Constants.Request.apiBaseURL + Constants.Request.detail
        }
    }
}
