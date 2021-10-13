//
//  HTTPHeaderBuilder.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

protocol HTTPRequestHeaderBuilder {
    func build(fromHeader header: HTTPRequestHeaders) -> HTTPRequestHeaders
}

struct DefaultHTTPRequestHeaderBuilder: HTTPRequestHeaderBuilder {
    
    init() { }
    
    func build(fromHeader header: HTTPRequestHeaders) -> HTTPRequestHeaders {
        var headers = header
        headers["Content-Type"] = "application/json"
        return headers
    }
}
