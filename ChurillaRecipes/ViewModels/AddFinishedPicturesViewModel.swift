//
//  AddFinishedPicturesViewModel.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 10/2/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

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
    
    /// Upload image as soon as image is picked
    ///
    /// - parameter image:     UIImage object
    /// - parameter completed: completion block
    func uploadImage(_ image: UIImage, completed: @escaping (Result<()>) -> Void) {
        guard let title = recipe.title else { return }
        uploader?.uploadImage(image, title: title + "\(recipe.finishedImages.count)", completion: { [weak self] (url) in
            self?.recipe.finishedImages.append(Image(imageUrlString: url))
            completed(Result.success())
            }, failure: { (reason) in
                completed(Result.failure(ObjectError.customError(error: reason)))
        })
    }
    
    func save(completion: @escaping (Bool) -> Void) {
        uploadRecipe(completion: { 
                completion(true)
            }) { (_) in
                completion(false)
        }
    }

    fileprivate func uploadRecipe(completion: @escaping () -> Void, failed: @escaping (_ err: ObjectError) -> Void) {
        store.addRecipe(recipe) { (result) in
            switch result {
            case .success(_):
                completion()
            case let .failure(_):
                break
            }
        }
    }
}

extension AddFinishedPicturesViewModel: DataSourceBinding {
    
    typealias CellViewModel = ImageCellViewModel
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsForSection(_ section: Int) -> Int {
        return recipe.finishedImages.count
    }
    
    func viewModelForIndexPath(_ indexPath: IndexPath) -> CellViewModel {
        return ImageCellViewModel(object: recipe.finishedImages[indexPath.row])
    }
}
