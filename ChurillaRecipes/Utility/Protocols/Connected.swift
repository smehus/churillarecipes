//
//  Connected.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal protocol Connected {
    associatedtype StoreType: Store
    init(store: StoreType)
}
