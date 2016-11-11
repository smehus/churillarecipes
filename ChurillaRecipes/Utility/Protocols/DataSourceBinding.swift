//
//  DataSourceBinding.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal protocol DataSourceBinding {
    
    associatedtype CellViewModel
    
    var numberOfSections: Int { get }
    
    func numberOfRowsForSection(_ section: Int) -> Int
    
    func viewModelForIndexPath(_ indexPath: IndexPath) -> CellViewModel
    
}
