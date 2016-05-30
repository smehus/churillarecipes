//
//  RecipeCellViewModel.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal struct RecipeCellViewModel: CellViewModel {
    
    var title: String {
        return recipe.title
    }
    
    var description: String {
        return recipe.description
    }
    
    var imageURL: NSURL {
        return recipe.recipeImages.first?.imageURL ?? NSURL()
    }
    
    typealias ObjectType = Recipe
    private let recipe: Recipe
    init(object: ObjectType) {
        self.recipe = object
    }
    
}
