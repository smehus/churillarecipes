//
//  RecipeFlyweight.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 10/2/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

// Used for passing back and forth while adding a recipe
internal final class RecipeFlyweight: RecipeBlueprint {
    
    var title: String?
    var description: String?
    var recipeImages = [Image]()
    var finishedImages = [Image]()
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    init(json: JSON) throws {
        throw ObjectError.customError(error: "blah")
    }
 
    func toJSON() -> APIParams {
        
        var params: Parameters = [:]
        params["title"] = title ?? ""
        params["description"] = description ?? ""
        let images: [String] = recipeImages.map {
            return $0.stringValue
        }
        
        let finished: [String] = finishedImages.map {
            return $0.stringValue
        }
        
        params["recipeImages"] = images
        params["finishedImages"] = finished
        return params
    }
}
