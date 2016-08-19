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
    
    func dequeueReusableCellForIndex<T: ReusableCell>(indexPath: NSIndexPath) -> T {
        
        guard let cell = self.dequeueReusableCellWithIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as? T else {
            fatalError()
        }
        
        return cell
    }
}

internal extension UICollectionView {
    
    func deqeueuReusableCellForIndex<T: ReusableCell>(indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCellWithReuseIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as? T else {
            fatalError()
        }
        
        return cell
    }
}
