//
//  ReusableCell.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

internal extension ReusableCell {
    
    static var reuseIdentifier: String {
        return String(self)
    }
    
}
