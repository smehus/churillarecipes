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
    
    func retrieveRecipes(_ completion: @escaping (Result<[Recipe]>) -> Void) -> Bool {
        let router = RecipeRouter(endPoint: .allRecipes)
        let _ = apiEnv.executeRequest(router) { (result) in
            
            switch result {
            case .success(_):
                do {
                    let objects: [Recipe] = try result.parseValue()
                    completion(Result.success(objects))
                } catch {
                    completion(Result.failure(ObjectError.mappingError))
                }
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
        
        return true
    }
    
    func addRecipe(_ recipe: RecipeBlueprint, completion: @escaping (Result<()>) -> Void) {
        let router = RecipeRouter(endPoint: .addRecipe(recipe: recipe))
        let _ = apiEnv.executeRequest(router) { result in
            
            switch result {
            case .success(_):
                completion(Result.success())
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func addFinishedImageToRecipe(_ recipe: Recipe, imageURL: String, completion: @escaping (Result<()>) -> Void) {
        let router = RecipeRouter(endPoint: .addFinishedImage(recipe: recipe, url: imageURL))
        let _ = apiEnv.executeRequest(router) { result in
            print("\(result.value)")
            switch result {
            case .success(_):
                completion(Result.success())
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
}
