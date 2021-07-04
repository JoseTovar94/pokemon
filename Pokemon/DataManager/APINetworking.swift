//
//  APINetworking.swift
//  Pokemon
//
//  Created by Jose Luis Tovar Jimenez on 1/07/21.
//

import Foundation
import Alamofire
import Material

class APINetworking {
    
    struct MultipartData {
        let data: Data
        let name: String
        let mimeType: MimeType
        
        enum MimeType: String {
            case jpeg = "image/jpeg"
            case png = "image/png"
        }
    }
    
    static func request<Response: Decodable, Params: Encodable>(route: APIRoute<Params>, multipartData: [MultipartData]? = nil, onSuccess: ((_ response: Response) -> Void)?, onError: ((Error) -> Void)?) {
        guard let urlRequest = try? route.asURLRequest() else {
            let error = NSError.initWith(title: "Error", detail: "No se pudo generar la petición")
            onError?(error)
            return
        }
        LogHelper.log(request: urlRequest)
        let failureBlock = {  (_ response: AFDataResponse<Any>, _ error: AFError) in
            if let data = response.data,
               let modelInstance = try?  JSONDecoder().decode(APIError.self, from: data) {
                let errorObject = modelInstance.toError()
                LogHelper.log(error: errorObject, request: urlRequest, type: Response.self)
                switch APIErrorEnum(rawValue: errorObject.code ?? "") {
                case .expiredOrMissingToken:
                    print("Refresh Token")
                default:
                    onError?(errorObject)
                }
            } else {
                if let data = response.data,
                   let string = String(data: data, encoding: .utf8) {
                    print(string)
                }
                LogHelper.log(error: error, request: urlRequest, type: Response.self)
                
                onError?(NSError.unknownError)
            }
        }
        
        let successBlock = {  (_ response: AFDataResponse<Any>, _ result: Any) in
            if let data = response.data {
                do {
                    let decodedObject = try JSONDecoder().decode(Response.self, from: data)
                    LogHelper.log(response: result, request: urlRequest, type: Response.self)
                    onSuccess?(decodedObject)
                } catch let DecodingError.typeMismatch(_, context) {
                    let error = NSError.initWith(code: "0", message: "La información obtenida no contiene el formato esperado.", title: "Error de información", detail: "\(context.debugDescription)\n \(context.codingPath)")
                    LogHelper.log(error: error, request: urlRequest, type: Response.self)
                    print(result)
                    onError?(NSError.unknownError)
                } catch {
                    LogHelper.log(error: error, request: urlRequest, type: Response.self)
                    onError?(NSError.unknownError)
                }
            } else {
                let error = NSError.initWith(title: "Error", detail: "La información obtenida no tiene el formato esperado.")
                LogHelper.log(error: error, request: urlRequest, type: Response.self)
                onError?(error)
            }
        }
        
        AF.request(urlRequest).validate(statusCode: 200..<300).downloadProgress(closure: { (_ progress) in }).responseJSON { (response) in
            switch response.result {
            case .failure(let error):
                failureBlock(response, error)
            case .success(let result):
                successBlock(response, result)
            }
        }
    }
}
