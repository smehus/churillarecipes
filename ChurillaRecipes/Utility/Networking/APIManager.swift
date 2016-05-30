//
//  APIManager.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/1/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

typealias Header = [String : String]

let Success = "success"
let ErrorMessage = "errorMessage"


internal struct APIManager: APIProtocol {
    
    let manager = Manager()
    
    var managerHeaders: Header {
        return [:]
    }
    
    init() {
        manager.session.configuration.HTTPAdditionalHeaders = managerHeaders
    }
    
    func executeRequest(router: Router, closure: Result<JSON, ObjectError> -> Void) -> Request {
        return manager.request(router).responseSwiftyJSON { response in
            print("\(response)")
            
            switch response.result {
            case .Success(let res):
                guard let success = res[Success].bool where success == true else {
                    switch res[ErrorMessage].string {
                    case .Some(let message):
                        closure(Result.Failure(ObjectError.ResponseError(error: message)))
                    case .None:
                        closure(Result.Failure(ObjectError.NetworkError))
                    }
                    return
                }
            
                closure(Result.Success(res))
                
            case .Failure(let error):
                closure(Result.Failure(ObjectError.ResponseError(error: error.localizedDescription)))
            }
            
        }
    }
}




