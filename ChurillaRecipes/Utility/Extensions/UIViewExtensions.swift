//
//  UIViewExtensions.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 8/28/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

internal struct AssociatedKeys {
    static var spinner = "_spinner_"
}

extension UIView {
    
    var activitySpinner: UIActivityIndicatorView {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.spinner) as? UIActivityIndicatorView ?? UIActivityIndicatorView()
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.spinner, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showActivitySpinner(style: UIActivityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge) {
        
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: style)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        addSubview(spinner)
        let y = spinner.centerYAnchor.constraintEqualToAnchor(self.centerYAnchor)
        let x = spinner.centerXAnchor.constraintEqualToAnchor(self.centerXAnchor)
        NSLayoutConstraint.activateConstraints([x, y])
        
        activitySpinner = spinner
    }
    
    
    func removeActivitySpinner() {
        activitySpinner.stopAnimating()
        activitySpinner.removeFromSuperview()
    }
    
}