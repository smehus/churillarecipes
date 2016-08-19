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
    
    private let store: RecipeStore
    private let uploader: ImageUploader?
    private var recipeImages = [String]()
    
    init(store: StoreType, uploader: ImageUploader) {
        self.store = store
        self.uploader = uploader
    }
    
    init(store: StoreType) {
        self.store = store
        self.uploader = nil
    }
}
