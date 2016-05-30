//
//  Object.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/7/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import SwiftyJSON

internal enum ObjectError: ErrorType {
    case CustomError(error: String)
    case MappingError
    case NetworkError
    case ResponseError(error: String)
    case ValidationError(error: String)
    
    var userFacingDescription: String {
        switch self {
        case .MappingError: return "Failed to map objects"
        case .NetworkError: return "Server failed"
        case .ResponseError(let error): return error
        case .CustomError(let error): return error
        case .ValidationError(let error): return error
        }
    }
    
}

internal protocol Object {
    
    init(json: JSON) throws
    
    func toJSON() -> APIParams
}


