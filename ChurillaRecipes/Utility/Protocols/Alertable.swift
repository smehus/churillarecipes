//
//  Alertable.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

internal protocol Alertable {
    func showAlert(_ title: String, message: String?)
}

extension Alertable where Self: UIViewController {
    
    func showAlert(_ title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithDismiss(_ title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
