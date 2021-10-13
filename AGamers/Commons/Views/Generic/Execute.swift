//
//  Execute.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import Foundation

struct Execute {
    
    static func onMain(_ block: @escaping () -> Void) {
        DispatchQueue.main.async {
            block()
        }
    }
    
}
