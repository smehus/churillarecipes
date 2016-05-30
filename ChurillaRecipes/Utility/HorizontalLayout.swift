//
//  HorizontalLayout.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/25/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit
import Foundation

internal final class HorizontalLayout: UICollectionViewLayout {

    var layoutAttributes =  [UICollectionViewLayoutAttributes]()
    var itemSize: CGSize!
    
    override func prepareLayout() {
        itemSize = CGSize(width: collectionView!.frame.size.width / 2, height: collectionView!.frame.size.height)
        layoutAttributes = (0..<collectionView!.numberOfItemsInSection(0)).map { i in
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: i, inSection: 0))
            attributes.size = itemSize
            attributes.frame = CGRect(origin: CGPoint(x: (itemSize.width + 10) * CGFloat(i), y: 0) , size: itemSize)
            return attributes
        }
    }

    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.row]
    }
    
    override func collectionViewContentSize() -> CGSize {
        let number = collectionView!.numberOfItemsInSection(0)
        return CGSize(width: (collectionView!.frame.size.width / 2) * CGFloat(number), height: collectionView!.frame.size.height)
    }
    
}
