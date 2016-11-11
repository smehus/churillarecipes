//
//  RecipeFlyweight.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 10/2/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

// Used for passing back and forth while adding a recipe
internal final class RecipeFlyweight {
    
    var title: String?
    var description: String?
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
}