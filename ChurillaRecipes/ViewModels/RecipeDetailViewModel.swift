//
//  RecipeDetailViewModel.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import Alamofire

internal class RecipeDetailViewModel: ViewModel {
    typealias StoreType = RecipeStore
    
    let store: RecipeStore
    let uploader: ImageUploader?
    
    var recipeTitle: String {
        guard let openedRecipe = recipe else {
            return ""
        }
        
        return openedRecipe.title
    }
    
    var recipeDescription: String {
        guard let openedRecipe = recipe else {
            return ""
        }
        
        return openedRecipe.description
    }
    
    var recipeImages: [Image] {
        guard let openedReciepe = recipe , openedReciepe.recipeImages.count > 0 else {
            return [Image]()
        }
        
        return openedReciepe.recipeImages
    }
    
    var finishedImages: [Image] {
        guard let openedReciepe = recipe , openedReciepe.finishedImages.count > 0 else {
            return [Image]()
        }
        
        return openedReciepe.finishedImages
    }
    
    fileprivate var recipe: Recipe?
    init(store: StoreType, recipe: Recipe) {
        self.store = store
        self.recipe = recipe
        self.uploader = nil
    }
    
    init(store: StoreType, recipe: Recipe, uploader: ImageUploader) {
        self.store = store
        self.recipe = recipe
        self.uploader = uploader
    }
    
    required init(store: StoreType) {
        self.store = store
        self.recipe = nil
        self.uploader = nil
    }
    
    func uploadImageAndUpdateRecipe(_ image: UIImage, completed: @escaping () -> Void, failed: @escaping (_ message: String) -> Void) {
        guard let imageUploader = uploader else {
            failed("Image Uploader Not Present")
            return
        }
        
        imageUploader.uploadImage(image, title: recipeTitle + "_finished_\(finishedImages.count)", completion: { (url) in
                self.addImageToRecipe(url, completed: completed, failed: failed)
            }) { (reason) in
                failed(reason)
        }
    }
    
    fileprivate func addImageToRecipe(_ url: String, completed: @escaping () -> Void, failed: @escaping (_ message: String) -> Void) {
        guard let strongRecipe = recipe else {
            failed("No Recipe Present")
            return
        }
        
        store.addFinishedImageToRecipe(strongRecipe, imageURL: url) { (result) in
            switch result {
            case .success(let recipe):
//                self.recipe = recipe
                completed()
            case .failure(let error):
                failed(error.localizedDescription)
            }
        }
    }
}



