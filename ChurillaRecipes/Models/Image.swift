//
//  Image.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/27/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import SwiftyJSON

internal struct Image: Object {
    
    var imageURL: NSURL {
        get {
            guard let url = NSURL(string: imageString) else {
                return NSURL()
            }
            
            return url
        }
    }
    
    var stringValue: String {
        return imageString
    }
    
    private let imageString: String
    
    init(imageUrlString: String) {
        self.imageString = imageUrlString
    }
    
    init(json: JSON) throws {
        throw ObjectError.MappingError
    }
    
    func toJSON() -> APIParams {
        return nil
    }
}
