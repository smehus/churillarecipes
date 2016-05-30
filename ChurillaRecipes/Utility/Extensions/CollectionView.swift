//
//  CollectionView.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/25/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func dequeueCollectionCellForIndex<T where T: ReusableCell>(indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCellWithReuseIdentifier(T.reuseIdentifier, forIndexPath: indexPath) as? T else {
            fatalError("Cell could not be deq")
        }
        
        return cell
    }
}
