//
//  Router.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

import Alamofire


typealias APIParams = [String: AnyObject]?

internal protocol Router: URLRequestConvertible {
    var method: Alamofire.Method { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: APIParams { get }
    var baseUrl: String { get }
}

extension Router {
    
    var baseUrl: String {
        return "https://whispering-crag-40905.herokuapp.com/"
    }
    
    var URLRequest: NSMutableURLRequest {
        guard let baseURL = NSURL(string: baseUrl) else {
            fatalError("bad url")
        }
        
        let mutableURLRequest = NSMutableURLRequest(URL: baseURL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        if let encoding = encoding {
            return encoding.encode(mutableURLRequest, parameters: parameters).0
        }
        return mutableURLRequest
    }
}

