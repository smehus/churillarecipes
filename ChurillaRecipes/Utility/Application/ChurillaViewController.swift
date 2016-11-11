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
    
    func presentView<T: UIViewController>(_ presentee: T.Type, viewModel: ViewModelType) where T: ChurillaViewController {
        let addController: T = T.parentStoryboard.instantiateViewController()
        self.present(addController, animated: true, completion: nil)
    }
    
    func pushView<T: UIViewController>(_ presentee: T.Type, viewModel: ViewModelType) where T: ChurillaViewController {
        let addController: T = T.parentStoryboard.instantiateViewController()
        self.navigationController?.pushViewController(addController, animated: true)
    }
    
}
