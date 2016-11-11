//
//  Router.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

import Alamofire


typealias APIParams = Parameters?

internal protocol Router: URLRequestConvertible {
    var method: HTTPMethod { get }
    var encoding: Alamofire.ParameterEncoding? { get }
    var path: String { get }
    var parameters: APIParams { get }
    var baseUrl: String { get }
}

extension Router {
    
    var baseUrl: String {
        return "https://whispering-crag-40905.herokuapp.com/"
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let baseURL = Foundation.URL(string: baseUrl) else {
            fatalError("bad url")
        }
        
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        if let encoding = encoding {
            return try encoding.encode(request, with: parameters)
        }
        
        return request
    }
    
}

