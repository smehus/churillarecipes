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
    
    func recipesViewModel(download: Observable<Bool>) -> RecipesViewModel {
        return RecipesViewModel(store: recipeStore(), configDownload: download)
    }
    
    func recipeDetailViewModel() -> RecipeDetailViewModel {
        return RecipeDetailViewModel(store: recipeStore())
    }
    
    func configStore() -> ConfigStore {
        return ConfigStore(environment: apiManager())
    }
    
    private func imageUploader() -> Amazon {
        return Amazon()
    }
    
}