//
//  Recipe.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import SwiftyJSON

internal struct Recipe: Object {
    
    let objectId: String
    let title: String
    let description: String
    let recipeImages: [Image]
    var finishedImages: [Image]
    
    init(json: JSON) throws {
        print("OBJECT BEING MAPPED\(json)")
        guard let title: String = json["title"].string,
            description: String = json["description"].string,
            urls: [JSON] = json["imageUrl"].array,
            _id: String = json["_id"].string
        else {
            throw ObjectError.MappingError
        }
        
        self.objectId = _id
        self.title = title
        self.description = description
        self.recipeImages = urls.map {
            return Image(imageUrlString: $0.string ?? "")
        }
        
        if let imageArray: [JSON] = json["finishedImageUrls"].array {
            self.finishedImages = imageArray.map {
                return Image(imageUrlString: $0.string ?? "")
            }
            
        } else {
            self.finishedImages = [Image]()
        }
    }
    
    init(title: String, description: String, imageUrl: String) {
        self.objectId = ""
        self.title = title
        self.description = description
        self.recipeImages = [Image(imageUrlString: imageUrl)]
        self.finishedImages = [Image]()
    }
    
    init(title: String, description: String, images: [Image]) {
        self.objectId = ""
        self.title = title
        self.description = description
        self.recipeImages = images
        self.finishedImages = [Image]()
    }
    
    
    func toJSON() -> APIParams {
        
        var params: [String: AnyObject] = [:]
        params["title"] = title
        params["description"] = description
        params["imageUrls"] = recipeImages.map {
            return $0.stringValue
        }
        
        return params
    }
}

