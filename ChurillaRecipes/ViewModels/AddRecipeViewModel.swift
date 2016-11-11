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
    
    func nextViewModel() -> AddRecipePicturesViewModel {
        guard let uploader = self.uploader else { fatalError() }
        return AddRecipePicturesViewModel(store: store, uploader: uploader, recipe: RecipeFlyweight(title: titleString, description: descriptionString))
    }
    
}
