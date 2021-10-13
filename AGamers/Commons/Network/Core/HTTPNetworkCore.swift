//
//  HTTPNetworkCore.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

protocol HTTPNetworkCore {
    func makeRequest<Request: HTTPRequest>(_ request: Request,
                                           completion: @escaping (Result<Request.Response, Error>) -> Void)
    func setCachePolicy(_ policy: URLRequest.CachePolicy)
    func setTimeoutInterval(_ interval: Int)
    func reset()
}


final class HTTPNetworkCoreImp: HTTPNetworkCore {
    
    private let configuration: HTTPNetworkConfiguration
    private let session: URLSession
    
    init(configuration: HTTPNetworkConfiguration) {
        self.configuration = configuration
        self.session = URLSession.shared
        self.session.configuration.timeoutIntervalForRequest = configuration.sessionConfiguration.timeoutIntervalForRequest
        self.session.configuration.requestCachePolicy = configuration.sessionConfiguration.requestCachePolicy
    }
    
    func makeRequest<Request: HTTPRequest>(_ request: Request,
                                           completion: @escaping (Result<Request.Response, Error>) -> Void) {
        
        /// build the request
        guard let urlRequest = try? configuration.requestBuilder.build(environment: configuration.environment,
                                                                       request: request) else {
            return completion(.failure(HTTPNetworkError.requestBuilderFailed))
        }
        
        let dataTask = session.dataTask(with: urlRequest) { [weak self] data, response, error in
            
            /// check for error
            if let _error = error {
                return completion(.failure(_error))
            }
            
            /// decode the response
            guard let this = self else { return }
            do {
                let decodedResponse = try this.configuration
                    .responseBuilder
                    .build(fromData: data, response: response, decodeTo: Request.Response.self)
                completion(.success(decodedResponse))
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func setCachePolicy(_ policy: URLRequest.CachePolicy) {
        session.configuration.requestCachePolicy = policy
    }
    
    func setTimeoutInterval(_ interval: Int) {
        session.configuration.timeoutIntervalForRequest = TimeInterval(interval)
    }
    
    func reset() {
        URLSession.shared.reset { }
    }
    
}
