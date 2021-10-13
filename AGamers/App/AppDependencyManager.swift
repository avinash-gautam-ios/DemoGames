//
//  DependencyManager.swift
//  AGamers
//
//  Created by Avinash Kumar Gautam on 11.10.21.
//

import Foundation

typealias Dependency = AppDependencyManager

/**
 - This class is resposible for managing app wide, shared dependencies
 */

final class AppDependencyManager {
    
    /// logger
    class var logger: Logger {
        return DebugLogger.shared
    }
    
    /// network core
    class var networkCore: HTTPNetworkCore {
        return HTTPNetworkProvider.shared.core
    }
    
}

