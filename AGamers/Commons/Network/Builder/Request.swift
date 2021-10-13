//
//  HTTPRequest.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 25.09.21.
//

import Foundation


typealias HTTPHeaders = [String: String]

protocol HTTPRequest  {
    associatedtype Response: Codable
    
    var headers: Headers { get set }
    var method: Method { get }
    var url:
}
