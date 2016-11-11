//
//  Array+JSON.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import SwiftyJSON

extension Array: Object {
    
    init(json: JSON) throws {
        
        guard let ElementType = Element.self as? Object.Type else {
            throw ObjectError.mappingError
        }
        
        var values = [Element]()
        for arrayObject in json {
            do {
                if let object = try ElementType.init(json: arrayObject.1) as? Element {
                    values.append(object)
                }
            } catch {
                throw ObjectError.mappingError
            }
        }
        
        
        self.init(values)
    }
    
    func toJSON() -> APIParams {
        return nil
    }
}
