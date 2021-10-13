//
//  HTTPNetworkError.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

enum HTTPNetworkError: Error {
    case requestBuilderFailed
    case internalServerError
    case apiNotFound
    case responseDataNil
    case unknown
    
    var message: String {
        return "Network error occured. Please try again."
    }
}

extension Error {
    var asNetworkError: HTTPNetworkError? {
        return self as? HTTPNetworkError
    }
}
