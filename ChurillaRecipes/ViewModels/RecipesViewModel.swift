//
//  RecipesViewModel.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal final class RecipesViewModel: ViewModel {
    typealias StoreType = RecipeStore
    
    let loading = Observable<Bool>(false)
    var configFinished: Observable<Bool>?
    
    fileprivate var recipes = [Recipe]()
    fileprivate let store: RecipeStore
    
    
    init(store: StoreType, configDownload: Observable<Bool>) {
        self.store = store
        self.configFinished = configDownload
    }
    
    init(store: StoreType) {
        self.store = store
    }
    
    func retrieveAllRecipes(success: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        loading.value = true
        store.retrieveRecipes { [weak self] (result) in
            self?.loading.value = false
            switch result {
            case let .success(recipes):
                self?.recipes = recipes
                success()
                return
            case let .failure(error):
                failure(error)
                return
            }
        }
    }
    
    func viewModelForAdding() -> AddRecipeViewModel {
        return AddRecipeViewModel(store: store, uploader: Amazon())
    }
    
    func detailViewModel(withIndex index: IndexPath) -> RecipeDetailViewModel {
        guard recipes.count >= (index.row - 1) else {
            fatalError("No recipe at index")
        }
        
        return RecipeDetailViewModel(store: store, recipe: recipes[index.row], uploader: Amazon())
    }
    
}

extension RecipesViewModel: DataSourceBinding {
    
    typealias CellViewModel = RecipeCellViewModel
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsForSection(_ section: Int) -> Int {
        return recipes.count
    }
    
    func viewModelForIndexPath(_ indexPath: IndexPath) -> CellViewModel {
        return RecipeCellViewModel(object: recipes[indexPath.row])
    }
}
