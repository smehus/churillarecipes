//
//  Object.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/7/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import SwiftyJSON

internal enum ObjectError: Error {
    case customError(error: String)
    case mappingError
    case networkError
    case responseError(error: String)
    case validationError(error: String)
    
    var userFacingDescription: String {
        switch self {
        case .mappingError: return "Failed to map objects"
        case .networkError: return "Server failed"
        case .responseError(let error): return error
        case .customError(let error): return error
        case .validationError(let error): return error
        }
    }
    
}

internal protocol Object {
    
    init(json: JSON) throws
    
    func toJSON() -> APIParams
}


