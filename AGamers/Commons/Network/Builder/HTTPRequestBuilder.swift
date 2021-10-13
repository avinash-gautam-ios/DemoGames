//
//  HTTPRequestBuilder.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

protocol HTTPRequestBuilder {
    init(headerBuilder: HTTPRequestHeaderBuilder, requestBodyBuilder: HTTPRequestBodyBuilder)
    
    func build<Request: HTTPRequest>(environment: HTTPEnvironment, request: Request) throws -> URLRequest
}

class DefaultHTTPRequestBuilder: HTTPRequestBuilder {
    
    private let requestBodyBuilder: HTTPRequestBodyBuilder
    private let headerBuilder: HTTPRequestHeaderBuilder
    
    required init(headerBuilder: HTTPRequestHeaderBuilder,
                  requestBodyBuilder: HTTPRequestBodyBuilder) {
        self.requestBodyBuilder = requestBodyBuilder
        self.headerBuilder = headerBuilder
    }
    
    func build<Request>(environment: HTTPEnvironment, request: Request) throws -> URLRequest where Request: HTTPRequest {
        var components = URLComponents()
        components.scheme = environment.scheme.rawValue
        components.host = environment.host.rawValue
        components.path = request.endpoint.path.value
        components.queryItems = request.endpoint.parameters
        
        guard let url = components.url else {
            throw HTTPNetworkError.requestBuilderFailed
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = headerBuilder.build(fromHeader: request.headers)
        
        /// check and add timeout interval to specific request
        if let _timeoutInterval = request.timeoutInterval {
            urlRequest.timeoutInterval = TimeInterval(_timeoutInterval)
        }
        
        /// check and add cache policy to the specific request
        if let _cachePolicy = request.cachePolicy {
            urlRequest.cachePolicy = _cachePolicy
        }
        
        /// check if body exists
        if let _body = request.body {
            do {
                urlRequest.httpBody = try requestBodyBuilder.build(fromHTTPBody: _body)
            } catch let error {
                throw error
            }
        }
        
        return urlRequest
    }
}


