//
//  Result+JSON.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/24/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

let Items = "items"

extension Result {
    
    func parseValue<T>() throws -> T where T: Object {
        guard let json = value as? JSON else {
            throw ObjectError.customError(error: "Result value is not JSON")
        }
        
        do {
            return try T(json: json[Items])
        } catch {
            throw ObjectError.mappingError
        }
    }
    
}
