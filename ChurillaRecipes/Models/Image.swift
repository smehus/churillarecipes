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
    
    var imageURL: URL? {
        get {
            guard let url = Foundation.URL(string: imageString) else {
                return nil
            }
            
            return url
        }
    }
    
    var stringValue: String {
        return imageString
    }
    
    fileprivate let imageString: String
    
    init(imageUrlString: String) {
        self.imageString = imageUrlString
    }
    
    init(json: JSON) throws {
        throw ObjectError.mappingError
    }
    
    func toJSON() -> APIParams {
        return nil
    }
}
