//
//  GameListingService.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import Foundation

class GameListingServiceRequest: HTTPRequest {
    typealias Response = GameListingAPIModel
    
    let method: HTTPMethodType
    let headers: HTTPRequestHeaders
    let endpoint: HTTPEndPoint
    
    init(endpoint: GameListingEndpoint) {
        self.method = .get
        self.headers = [:]
        self.endpoint = endpoint
    }
}
