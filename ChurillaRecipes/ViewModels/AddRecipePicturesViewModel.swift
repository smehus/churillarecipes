//
//  AddRecipePicturesViewModel.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 10/1/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import Alamofire

internal final class AddRecipePicturesViewModel: ViewModel {
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
    
    func nextViewModel() -> AddFinishedPicturesViewModel {
        guard let uploader = self.uploader else { fatalError() }
        return AddFinishedPicturesViewModel(store: store, uploader: uploader, recipe: recipe)
    }
    
    
    /// Upload image as soon as image is picked
    ///
    /// - parameter image:     UIImage object
    /// - parameter completed: completion block
    func uploadImage(_ image: UIImage, completed: @escaping (Result<()>) -> Void) {
        guard let title = recipe.title else { return }
        uploader?.uploadImage(image, title: title + "\(recipe.recipeImages.count)", completion: { [weak self] (url) in
            self?.recipe.recipeImages.append(Image(imageUrlString: url))
            completed(Result.success())
            }, failure: { (reason) in
                completed(Result.failure(ObjectError.customError(error: reason)))
        })
    }
}

extension AddRecipePicturesViewModel: DataSourceBinding {
    
    typealias CellViewModel = ImageCellViewModel
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsForSection(_ section: Int) -> Int {
        return recipe.recipeImages.count
    }
    
    func viewModelForIndexPath(_ indexPath: IndexPath) -> CellViewModel {
        return ImageCellViewModel(object: recipe.recipeImages[indexPath.row])
    }
}
