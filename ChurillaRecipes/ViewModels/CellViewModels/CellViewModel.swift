//
//  CellViewModel.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal protocol CellViewModel {
    
    associatedtype ObjectType: Object
    init(object: ObjectType)
    
}
