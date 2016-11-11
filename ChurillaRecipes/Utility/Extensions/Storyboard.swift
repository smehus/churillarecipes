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
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController, D: ViewModel>(_ viewModel: D) -> T where T: ChurillaViewController {
        guard var controller = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Failed to find storyboard file")
        }

        controller.viewModel = viewModel as? T.ViewModelType
        return controller
    }
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        let optionalViewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier)
        guard let viewController = optionalViewController as? T else {
            fatalError("Failed to find storyboard file")
        }
        
        return viewController
    }
    
}
