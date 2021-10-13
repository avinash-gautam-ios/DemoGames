//
//  Logger.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 29.09.21.
//

import Foundation

enum LogType: String {
    case critial
    case error
    case message
    
    var prefix: String {
        switch self {
        case .critial:
            return "(🚒 CRITICAL) => "
        case .error:
            return "(🔴 ERROR) => "
        case .message:
            return "(✉️ MESSAGE) => "
        }
    }
}

protocol Logger: Any {
    func log(type: LogType, _ message: Any)
}


class DebugLogger: Logger {
    
    private struct Static {
        static let S = DebugLogger()
    }
    
    static var shared: Logger {
        return Static.S
    }
    
    func log(type: LogType, _ message: Any) {
        #if DEBUG
        print(type.prefix + "\(message)")
        #endif
    }
}
