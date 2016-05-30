//
//  AppInjector.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/10/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal struct AppInjector {
    
    func apiManager() -> APIProtocol {
        return APIManager()
    }
    
    func splitControllerManager() -> SplitControllerManagerProtocol {
        return SplitControllerManager()
    }
    
    func recipeStore() -> RecipeStore {
        return RecipeStore(environment: apiManager())
    }
    
    func recipesViewModel() -> RecipesViewModel {
        return RecipesViewModel(store: recipeStore())
    }
    
    func recipeDetailViewModel() -> RecipeDetailViewModel {
        return RecipeDetailViewModel(store: recipeStore())
    }
    
    private func imageUploader() -> Amazon {
        return Amazon()
    }
    
}