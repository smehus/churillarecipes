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
    
    func dequeueCollectionCellForIndex<T>(_ indexPath: IndexPath) -> T where T: ReusableCell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Cell could not be deq")
        }
        
        return cell
    }
}
