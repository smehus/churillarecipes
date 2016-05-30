//
//  ViewModelBindable.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal protocol ViewModelBindable {
    
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType! { get set }
    
}
