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
    
    var imageURL: URL? {
        return recipe.recipeImages.first?.imageURL
    }
    
    typealias ObjectType = Recipe
    fileprivate let recipe: Recipe
    init(object: ObjectType) {
        self.recipe = object
    }
    
}
