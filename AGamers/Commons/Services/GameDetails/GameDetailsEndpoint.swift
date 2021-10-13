//
//  GameDetailsEndpoint.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 12.10.21.
//

import Foundation

struct GameDetailsEndPoint: HTTPEndPoint {
    let parameters: HTTPRequesQueryParams
    let path: HTTPURLType
    
    init(id: Int) {
        self.path = .gameDetails
        self.parameters = [URLQueryItem(name: "id", value: String(id))]
    }
    
}
