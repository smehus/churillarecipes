//
//  AssertUnwrap.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/16/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal func assertUnwrap<T>(_ validator: () -> T?) -> T {
    guard let value = validator() else {
        fatalError("Object doesn't exist")
    }
    
    return value
}
