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
    case DebugAll
    case AllRecipes
    case AddRecipe(recipe: Recipe)
    case GetRecipe(name: String)
    case AddFinishedImage(recipe: Recipe, url: NSString)
    
    
    var endPointPath: String {
        switch self {
            case .AllRecipes: return "all"
            case .AddRecipe: return "add"
            case .GetRecipe: return "search"
            case .AddFinishedImage: return "addFinishedImage"
            
            case .DebugAll: return "debugall"
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
    
    var method: Alamofire.Method {
        switch endPoint {
            case .AllRecipes: return .GET
            case .AddRecipe: return .POST
            case .GetRecipe: return .GET
            case .AddFinishedImage: return .PUT
            
            case .DebugAll: return .GET
        }
    }
    
    var path: String {
        return endPoint.endPointPath
    }
    
    var parameters: APIParams {
        switch endPoint {
            case .AllRecipes: return nil
            case .AddRecipe(let recipe): return recipe.toJSON()
            case .GetRecipe: return nil
            case .AddFinishedImage(let recipe, let url): return ["_id": recipe.objectId, "url": url]
            
            case .DebugAll: return nil
        }
    }
    
    var encoding: ParameterEncoding? {
            switch endPoint {
                case .AllRecipes: return .JSON
                case .AddRecipe: return .JSON
                case .GetRecipe: return .JSON
                case .AddFinishedImage: return .JSON
                
                case .DebugAll: return .JSON
        }
    }
 
}
