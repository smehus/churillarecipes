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
    fileprivate var recipeImages = [String]()
    
    init(store: StoreType, uploader: ImageUploader) {
        self.store = store
        self.uploader = uploader
    }
    
    init(store: StoreType) {
        self.store = store
        self.uploader = nil
    }
}
