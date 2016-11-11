//
//  AddFinishedPicturesViewModel.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 10/2/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal final class AddFinishedPicturesViewModel: ViewModel {
    typealias StoreType = RecipeStore
    
    fileprivate let store: RecipeStore
    fileprivate let uploader: ImageUploader?
    fileprivate var recipe: RecipeFlyweight
    
    init(store: StoreType, uploader: ImageUploader, recipe: RecipeFlyweight) {
        self.store = store
        self.uploader = uploader
        self.recipe = recipe
    }
    
    init(store: StoreType) {
        fatalError()
    }
    
    
    fileprivate func uploadRecipe(_ urls: [String], completion: @escaping () -> Void, failed: @escaping (_ err: ObjectError) -> Void) {
        store.addRecipe(recipe) { (result) in
            switch result {
            case .success(_):
                completion()
            case let .failure(err):
                break
            }
        }
    }
    
    fileprivate func createRecipeObject(_ title: String, description: String, imageURLs: [String]) -> Recipe {
        let images = imageURLs.map {
            return Image(imageUrlString: $0)
        }
        return Recipe(title: title, description: description, images: images)
    }
}
