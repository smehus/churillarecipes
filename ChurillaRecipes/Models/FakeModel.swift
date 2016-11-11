//
//  FakeModel.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/7/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

internal struct FakeModel: Object {
    
    let objectId: Int
    let thing: String
    
    init(json: JSON) throws {
        
        guard let first: String = json["model"].stringValue,
            let id: Int = json["_id"].intValue
        else {
            throw ObjectError.mappingError
        }
        
        objectId = id
        thing = first
    }
    
    func toJSON() -> APIParams {
        return nil
    }
    
}


extension JSON {
     var fakeModel: FakeModel?  {
        get {
            do {
                return try FakeModel(json: self)
            } catch {
                return nil
            }
        }
    }
}
