//
//  HTTPEndPoint.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

protocol HTTPEndPoint {
    var parameters: HTTPRequesQueryParams { get }
    var path: HTTPURLType { get }
}
