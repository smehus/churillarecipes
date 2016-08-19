//
//  Archivable.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 8/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

typealias URL = NSURL
typealias Data = NSData

internal protocol Archivable {
    static func path() -> URL
    func path() -> URL
    func archived() -> Data
}

