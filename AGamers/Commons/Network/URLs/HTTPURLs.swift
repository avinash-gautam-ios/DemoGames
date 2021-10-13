//
//  HTTPURLs.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 12.10.21.
//

import Foundation

enum HTTPURLType: String {
    case listing
    case gameDetails
    
    var value: String {
        switch self {
        case .listing:
            return "/api/games"
        case .gameDetails:
            return "/api/game"
        }
    }
}
