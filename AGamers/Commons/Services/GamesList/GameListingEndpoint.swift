//
//  GameListingEndpoint.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import Foundation

struct GameListingEndpoint: HTTPEndPoint {
    
    let parameters: HTTPRequesQueryParams
    let path: HTTPURLType
    
    init(platform: [String],
         sorting: [String],
         category: [String]) {
        self.path = .listing
        var params = [URLQueryItem]()
        
        /// sorting params
        if sorting.count > 0 {
            params.append(URLQueryItem(name: "sort-by", value: sorting.joined(separator: ",")))
        }
        /// category params
        if category.count > 0 {
            params.append(URLQueryItem(name: "category", value: category.joined(separator: ",")))
        }
        /// platform params
        if platform.count > 0 {
            params.append(URLQueryItem(name: "platform", value: platform.joined(separator: ",")))
        }
        self.parameters = params
    }
}
