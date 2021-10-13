//
//  HTTPBodyBuilder.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

protocol HTTPRequestBodyBuilder {
    func build(fromHTTPBody body: HTTPRequestBody) throws -> Data?
}

struct DefaultHTTPRequestBodyBuilder: HTTPRequestBodyBuilder {
    
    init() { }
    
    func build(fromHTTPBody body: HTTPRequestBody) throws -> Data? {
        return try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
    }
    
}
