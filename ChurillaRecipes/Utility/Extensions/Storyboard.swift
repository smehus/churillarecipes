//
//  Storyboard.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/9/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    enum Storyboard: String {
        case Main
        case Detail
    }
    
    convenience init(storyboard: Storyboard, bundle: NSBundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController, D: ViewModel where T: ChurillaViewController>(viewModel: D) -> T {
        guard var controller = self.instantiateViewControllerWithIdentifier(T.storyboardIdentifier) as? T else {
            fatalError("Failed to find storyboard file")
        }

        controller.viewModel = viewModel as? T.ViewModelType
        return controller
    }
    
    func instantiateViewController<T: UIViewController where T: StoryboardIdentifiable>() -> T {
        let optionalViewController = self.instantiateViewControllerWithIdentifier(T.storyboardIdentifier)
        guard let viewController = optionalViewController as? T else {
            fatalError("Failed to find storyboard file")
        }
        
        return viewController
    }
    
}
