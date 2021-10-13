//
//  HTTPNetworkConfiguration.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

struct HTTPNetworkConfiguration {
    let environment: HTTPEnvironment
    let requestBuilder: HTTPRequestBuilder
    let responseBuilder: HTTPResponseBuilder
    let sessionConfiguration: URLSessionConfiguration
    
    init(timeoutInterval: Int,
         cachePolicy: URLRequest.CachePolicy,
         environment: HTTPEnvironment,
         requestBuilder: HTTPRequestBuilder,
         responseBuilder: HTTPResponseBuilder) {
        self.environment = environment
        self.requestBuilder = requestBuilder
        self.responseBuilder = responseBuilder
        self.sessionConfiguration = URLSessionConfiguration()
        self.sessionConfiguration.timeoutIntervalForRequest = TimeInterval(timeoutInterval)
        self.sessionConfiguration.requestCachePolicy = cachePolicy
    }
    
}
