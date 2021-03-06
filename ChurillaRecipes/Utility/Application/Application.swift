//
//  Application.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/10/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

internal struct Application {
    
    let injector: AppInjector
    let splitControllerManager: SplitControllerManagerProtocol
    let configStore: ConfigStore
    
    init() {
        injector = AppInjector()
        configStore = injector.configStore()
        splitControllerManager = injector.splitControllerManager()
    }
    
    func run() -> Bool {
        
        guard let delegate = UIApplication.shared.delegate as? AppDelegate, let appWindow = delegate.window else {
            return false
        }
        
        // Split Controller
        let splitViewController = appWindow.rootViewController as! UISplitViewController
        
        // Master Controller
        let leftNav = splitViewController.viewControllers.first as! UINavigationController
        let master = leftNav.topViewController as! RecipeCollectionViewController
        master.viewModel = injector.recipesViewModel(configStore.configFileDownload)
        
        // Detail Controller
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        let detail = navigationController.topViewController! as! RecipeDetailViewController
        detail.viewModel = injector.recipeDetailViewModel()
        
        // Doesn't work to set the delegate to splitcontrollermanager for some reason.... test later
        splitViewController.delegate = delegate
        
        configStore.downloadConfig()
        
        return true
    }
}
