//
//  SegueIdentifiable.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/27/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

internal protocol SegueIdentifiable {
    static var segueIdentifier: String { get }
}

extension SegueIdentifiable where Self: UIViewController {
    static var segueIdentifier: String {
        return String(self)
    }
}
