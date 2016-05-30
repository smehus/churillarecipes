//
//  RecipeStore.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 5/30/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

internal struct RecipeStore: Store {
    
    let apiEnv: APIProtocol
    
    init(environment: APIProtocol) {
        self.apiEnv = environment
    }
    
    func retrieveRecipes(completion: Result<[Recipe], ObjectError> -> Void) -> Bool {
        let router = RecipeRouter(endPoint: .AllRecipes)
        let _ = apiEnv.executeRequest(router) { (result) in
            
            switch result {
            case .Success(_):
                do {
                    let objects: [Recipe] = try result.parseValue()
                    completion(Result.Success(objects))
                } catch {
                    completion(Result.Failure(.MappingError))
                }
                
            case .Failure(let error):
                completion(Result.Failure(error))
            }
        }
        
        return true
    }
    
    func addRecipe(recipe: Recipe, completion: Result<(), ObjectError> -> Void) {
        let router = RecipeRouter(endPoint: .AddRecipe(recipe: recipe))
        let _ = apiEnv.executeRequest(router) { result in
            
            switch result {
            case .Success(_):
                completion(Result.Success())
            case .Failure(let error):
                completion(Result.Failure(error))
            }
        }
    }
    
    func addFinishedImageToRecipe(recipe: Recipe, imageURL: String, completion: Result<(), ObjectError> -> Void) {
        let router = RecipeRouter(endPoint: .AddFinishedImage(recipe: recipe, url: imageURL))
        let _ = apiEnv.executeRequest(router) { result in
            print("\(result.value)")
            switch result {
            case .Success(_):
                completion(Result.Success())
            case .Failure(let error):
                completion(Result.Failure(error))
            }
        }
    }
    
}
