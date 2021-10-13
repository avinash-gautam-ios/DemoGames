//
//  HTTPRequest.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 25.09.21.
//

import Foundation

/// http body
typealias HTTPRequestBody = [String: String]

/// query params
typealias HTTPRequesQueryParams = [URLQueryItem]

/// headers
typealias HTTPRequestHeaders = [String: String]


protocol HTTPRequest {
    associatedtype Response: Decodable
    
    var method: HTTPMethodType { get }
    var endpoint: HTTPEndPoint { get }
    var headers: HTTPRequestHeaders { get }
    var body: HTTPRequestBody? { get }
    var timeoutInterval: Int? { get }
    var cachePolicy: URLRequest.CachePolicy? { get }
}

extension HTTPRequest {
    var body: HTTPRequestBody? {
        return nil
    }
    
    var timeoutInterval: Int? {
        return nil
    }
    
    var cachePolicy: URLRequest.CachePolicy? {
        return nil
    }
}
