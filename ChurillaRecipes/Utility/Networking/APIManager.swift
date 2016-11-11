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
    
    let manager = SessionManager()
    
    var managerHeaders: Header {
        return [:]
    }
    
    init() {
        manager.session.configuration.httpAdditionalHeaders = managerHeaders
    }
    
    func executeRequest(_ router: Router, closure: @escaping (Result<JSON>) -> Void) -> Request {

        return manager.request(router).responseSwiftyJSON { response in
            print("\(response)")
            
            switch response.result {
            case .success(let res):
                guard let success = res[Success].bool , success == true else {
                    switch res[ErrorMessage].string {
                    case .some(let message):
                        closure(Result.failure(ObjectError.responseError(error: message)))
                    case .none:
                        closure(Result.failure(ObjectError.networkError))
                    }
                    return
                }
            
                closure(Result.success(res))
                
            case .failure(let error):
                closure(Result.failure(ObjectError.responseError(error: error.localizedDescription)))
            }
            
        }
    }
}




