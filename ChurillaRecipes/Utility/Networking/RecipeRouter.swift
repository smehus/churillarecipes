//
//  RecipeRouter.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/1/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import Alamofire

internal enum RecipeEndPoint {
    case debugAll
    case allRecipes
    case addRecipe(recipe: RecipeBlueprint)
    case getRecipe(name: String)
    case addFinishedImage(recipe: Recipe, url: String)
    
    
    var endPointPath: String {
        switch self {
            case .allRecipes: return "all"
            case .addRecipe: return "add"
            case .getRecipe: return "search"
            case .addFinishedImage: return "addFinishedImage"
            
            case .debugAll: return "debugall"
        }
    }
}

internal struct RecipeRouter {
    
    var endPoint: RecipeEndPoint
    init(endPoint: RecipeEndPoint) {
        self.endPoint = endPoint
    }
}

extension RecipeRouter: Router {
    
    var method: HTTPMethod {
        switch endPoint {
            case .allRecipes: return .get
            case .addRecipe: return .post
            case .getRecipe: return .get
            case .addFinishedImage: return .put
            
            case .debugAll: return .get
        }
    }
    
    var path: String {
        return endPoint.endPointPath
    }
    
    var parameters: APIParams {
        switch endPoint {
            case .allRecipes: return nil
            case .addRecipe(let recipe): return recipe.toJSON()
            case .getRecipe: return nil
            case .addFinishedImage(let recipe, let url): return ["_id": recipe.objectId, "url": url]
            
            case .debugAll: return nil
        }
    }
    
    var encoding: ParameterEncoding? {
            switch endPoint {
                case .allRecipes: return JSONEncoding.default
                case .addRecipe: return JSONEncoding.default
                case .getRecipe: return JSONEncoding.default
                case .addFinishedImage: return JSONEncoding.default
                
                case .debugAll: return JSONEncoding.default
        }
    }
 
}
