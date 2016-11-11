//
//  StoryboardIdentifiable.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/9/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

internal protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
    static var parentStoryboard: UIStoryboard { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    // Default storyboard - need to override in each class if different storyboard
    static var parentStoryboard: UIStoryboard  {
        return UIStoryboard(storyboard: .Main)
    }
}

