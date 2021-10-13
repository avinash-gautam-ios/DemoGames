//
//  HTTPResponseBuilder.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

protocol HTTPResponseBuilder {
    func build<T: Decodable>(fromData data: Data?,
                             response: URLResponse?,
                             decodeTo modelType: T.Type) throws -> T
}

struct DefaultHTTPResponseBuilder: HTTPResponseBuilder {
    
    func build<T>(fromData data: Data?,
                  response: URLResponse?,
                  decodeTo modelType: T.Type) throws -> T where T: Decodable {
        
        /// if both are nil, just return with failure
        if (response == nil) && (data == nil) {
            throw HTTPNetworkError.unknown
        }
        
        /// check for status code
        if let urlResponse = response as? HTTPURLResponse,
           let status = HTTPNetworkStatusCode(rawValue: urlResponse.statusCode) {
            switch status {
            case .success:
                /// is status code is success check for data
                guard let _data = data else {
                    throw HTTPNetworkError.responseDataNil
                }
                
                /// decode the data to model
                return try decode(from: _data, toModel: modelType.self)
            case .serverError:
                throw HTTPNetworkError.internalServerError
            case .notFound:
                throw HTTPNetworkError.apiNotFound
            }
        }
        
        throw HTTPNetworkError.unknown
    }
    
    func decode<T: Decodable>(from data: Data, toModel modelType: T.Type) throws -> T {
        do {
            return try JSONDecoder().decode(modelType, from: data)
        } catch let error {
            throw error
        }
    }
    
}
