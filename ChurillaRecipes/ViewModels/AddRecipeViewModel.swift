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
        return (pictureButtonActive) ? UIColor.blue : UIColor.blue.withAlphaComponent(0.8)
    }
    
    fileprivate let store: RecipeStore
    fileprivate let uploader: ImageUploader?
    
    init(store: StoreType, uploader: ImageUploader) {
        self.store = store
        self.uploader = uploader
    }
    
    init(store: StoreType) {
        self.store = store
        self.uploader = nil
    }
    
    func saveRecipe(_ completion: @escaping () -> Void, failed: @escaping (_ err: ObjectError) -> Void) {
        
        guard recipeImages.count > 0 && titleString.characters.count > 0 else {
            failed(ObjectError.validationError(error: "Please fill out title and add a picture"))
            return
        }
        
        self.uploadRecipe(recipeImages, completion: completion, failed: failed)
    }
    
    func nextViewModel() -> AddRecipePicturesViewModel {
        guard let uploader = self.uploader else { fatalError() }
        return AddRecipePicturesViewModel(store: store, uploader: uploader, recipe: RecipeFlyweight(title: titleString, description: descriptionString))
    }
    
    fileprivate func uploadRecipe(_ urls: [String], completion: @escaping () -> Void, failed: @escaping (_ err: ObjectError) -> Void) {
        let params = createRecipeObject(titleString, description: descriptionString, imageURLs: urls)
        store.addRecipe(params) { (result) in
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

extension AddRecipeViewModel: DataSourceBinding {
    typealias CellViewModel = ImageCellViewModel
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsForSection(_ section: Int) -> Int {
        return recipeImages.count
    }
    
    func viewModelForIndexPath(_ indexPath: IndexPath) -> CellViewModel {
        return ImageCellViewModel(object: Image(imageUrlString: recipeImages[indexPath.row]))
    }
}



