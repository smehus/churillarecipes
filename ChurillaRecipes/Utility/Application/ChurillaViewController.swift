//
//  ChurillaViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 5/30/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

protocol ChurillaViewController: StoryboardIdentifiable, ViewModelBindable, Alertable, SegueIdentifiable {
    
}

extension ChurillaViewController where Self: UIViewController {
    
    func presentView<T: UIViewController where T: ChurillaViewController>(presentee: T.Type, viewModel: ViewModelType) {
        let addController: T = T.parentStoryboard.instantiateViewController()
        self.presentViewController(addController, animated: true, completion: nil)
    }
    
    func pushView<T: UIViewController where T: ChurillaViewController>(presentee: T.Type, viewModel: ViewModelType) {
        let addController: T = T.parentStoryboard.instantiateViewController()
        self.navigationController?.pushViewController(addController, animated: true)
    }
    
}
