//
//  TableView.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

internal extension UITableView {
    
    func dequeueReusableCellForIndex<T: ReusableCell>(_ indexPath: IndexPath) -> T {
        
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError()
        }
        
        return cell
    }
}

internal extension UICollectionView {
    
    func deqeueuReusableCellForIndex<T: ReusableCell>(_ indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError()
        }
        
        return cell
    }
}
