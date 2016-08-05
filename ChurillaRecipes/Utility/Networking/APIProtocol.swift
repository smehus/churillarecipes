//
//  APIProtocol.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/10/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

internal protocol APIProtocol {
    func executeRequest(router: Router, closure: Result<JSON, ObjectError> -> Void) -> Request
}