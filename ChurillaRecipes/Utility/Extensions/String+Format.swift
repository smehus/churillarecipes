//
//  String+Format.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/24/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation


extension String {
    
    func removeSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "_")
    }
}
