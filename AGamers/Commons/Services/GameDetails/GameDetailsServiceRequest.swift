//
//  GameDetailsServiceRequest.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 12.10.21.
//

import Foundation

class GameDetailsServiceRequest: HTTPRequest {
    typealias Response = GameDetailsAPIModel
    
    let method: HTTPMethodType
    let headers: HTTPRequestHeaders
    let endpoint: HTTPEndPoint
    
    init(endpoint: GameDetailsEndPoint) {
        self.method = .get
        self.headers = [:]
        self.endpoint = endpoint
    }
}
