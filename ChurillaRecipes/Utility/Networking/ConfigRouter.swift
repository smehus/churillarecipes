//
//  ConfigRouter.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 8/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Alamofire
import Foundation

internal struct ConfigRouter: Router {
    
    var method: Alamofire.Method {
        return .GET
    }
    
    var path: String {
        return "config"
    }
    
    var parameters: APIParams {
        return nil
    }
    
    var encoding: ParameterEncoding? {
        return nil
    }
}