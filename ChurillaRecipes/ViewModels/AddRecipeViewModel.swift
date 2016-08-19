//
//  AddRecipeViewModel.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/16/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit
import Alamofire

internal final class AddRecipeViewModel: ViewModel {
    typealias StoreType = RecipeStore
    
    var recipeImages = [String]()
    var titleString = ""
    var descriptionString = ""
    
    var pictureButtonActive: Bool {
        return titleString.characters.count > 0
    }
    
    var pictureButtonColor: UIColor {
        return (pictureButtonActive) ? UIColor.blueColor() : UIColor.blueColor().colorWithAlphaComponent(0.8)
    }
    
    private let store: RecipeStore
    private let uploader: ImageUploader?
    
    init(store: StoreType, uploader: ImageUploader) {
        self.store = store
        self.uploader = uploader
    }
    
    init(store: StoreType) {
        self.store = store
        self.uploader = nil
    }
    
    func saveRecipe(completion: () -> Void, failed: (err: ObjectError) -> Void) {
        
        guard recipeImages.count > 0 && titleString.characters.count > 0 else {
            failed(err: ObjectError.ValidationError(error: "Please fill out title and add a picture"))
            return
        }
        
        self.uploadRecipe(recipeImages, completion: completion, failed: failed)
    }
    
    func nextViewModel() -> AddRecipePicturesViewModel {
        guard let uploader = self.uploader else { fatalError() }
        return AddRecipePicturesViewModel(store: store, uploader: uploader, recipe: RecipeFlyweight(title: titleString, description: descriptionString))
    }
    
    private func uploadRecipe(urls: [String], completion: () -> Void, failed: (err: ObjectError) -> Void) {
        let params = createRecipeObject(titleString, description: descriptionString, imageURLs: urls)
        store.addRecipe(params) { (result) in
            switch result {
            case .Success(_):
                completion()
            case let .Failure(err):
                failed(err: err)
            }
        }
    }
    
    private func createRecipeObject(title: String, description: String, imageURLs: [String]) -> Recipe {
        let images = imageURLs.map {
            return Image(imageUrlString: $0)
        }
        return Recipe(title: title, description: description, images: images)
    }
    
}

extension AddRecipeViewModel: DataSourceBinding {
    typealias CellViewModel = ImageCellViewModel
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsForSection(section: Int) -> Int {
        return recipeImages.count
    }
    
    func viewModelForIndexPath(indexPath: NSIndexPath) -> CellViewModel {
        return ImageCellViewModel(object: Image(imageUrlString: recipeImages[indexPath.row]))
    }
}



