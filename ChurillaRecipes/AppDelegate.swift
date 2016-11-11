//
//  AppDelegate.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 5/29/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit


// TODO:
// Sign in page - make the split view the home page - but present sign in as modal - seems like best way

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let app = Application()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        return app.run()
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
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

