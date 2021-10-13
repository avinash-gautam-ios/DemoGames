//
//  HTTPEnvironment.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

protocol HTTPEnvironment {
    var scheme: HTTPSchemeType { get }
    var environment: HTTPEnvironmentType { get }
    var host: HTTPEnvironmentType.HTTPHostType { get }
}

struct ProdEnvironment: HTTPEnvironment {
    let scheme: HTTPSchemeType
    let environment: HTTPEnvironmentType
    let host: HTTPEnvironmentType.HTTPHostType
    
    init() {
        self.scheme = .https
        self.environment = .prod
        self.host = HTTPEnvironmentType.HTTPHostType.prod
    }
}
