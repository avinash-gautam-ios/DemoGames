//
//  HTTPNetworkProvider.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

typealias HTTP = HTTPNetworkProvider

class HTTPNetworkProvider {
    let core: HTTPNetworkCore
    
    private struct Static {
        static let S = HTTPNetworkProvider()
    }
    
    init(requestBuilder: HTTPRequestBuilder,
         responseBuilder: HTTPResponseBuilder,
         environment: HTTPEnvironment,
         timeoutInterval: Int,
         cachePolicy: URLRequest.CachePolicy) {
        let configuration = HTTPNetworkConfiguration(timeoutInterval: timeoutInterval,
                                                     cachePolicy: cachePolicy,
                                                     environment: environment,
                                                     requestBuilder: requestBuilder,
                                                     responseBuilder: responseBuilder)
        self.core = HTTPNetworkCoreImp(configuration: configuration)
    }
    
    init() {
        let headerBuilder = DefaultHTTPRequestHeaderBuilder()
        let bodyBuilder = DefaultHTTPRequestBodyBuilder()
        let requestBuilder = DefaultHTTPRequestBuilder(headerBuilder: headerBuilder, requestBodyBuilder: bodyBuilder)
        let responseBuilder = DefaultHTTPResponseBuilder()
        let environment = ProdEnvironment()
        let timeoutPolicy = HTTPConstants.defaultTimeoutInterval
        let cachePolicy = HTTPConstants.defaultCachePolicy
        let configuration = HTTPNetworkConfiguration(timeoutInterval: timeoutPolicy,
                                                     cachePolicy: cachePolicy,
                                                     environment: environment,
                                                     requestBuilder: requestBuilder,
                                                     responseBuilder: responseBuilder)
        self.core = HTTPNetworkCoreImp(configuration: configuration)
    }
    
    static var shared: HTTPNetworkProvider {
        return Static.S
    }
}
