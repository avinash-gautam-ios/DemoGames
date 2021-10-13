//
//  HTTPTypes.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

enum HTTPEnvironmentType: Int {
    case prod
    
    enum HTTPHostType: String {
        case prod = "www.freetogame.com"
    }
    
    func host() -> HTTPHostType {
        switch self {
        case .prod:
            return HTTPHostType.prod
        }
    }
}

enum HTTPSchemeType: String {
    case https = "https"
    case http = "http"
}

enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
    var value: String {
        return self.rawValue
    }
}


