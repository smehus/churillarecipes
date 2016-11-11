//
//  SplitControllerManager.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/10/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

internal final class SplitControllerManager: NSObject, SplitControllerManagerProtocol {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? RecipeDetailViewController else { return false }
        return true
//        if topAsDetailController.detailItem == nil {
//            // if theres no detail object, then colaps
//            return true
//        }
//        return false
    }
}
