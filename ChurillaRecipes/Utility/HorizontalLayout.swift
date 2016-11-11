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
    
    override func prepare() {
        itemSize = CGSize(width: collectionView!.frame.size.width / 2, height: collectionView!.frame.size.height)
        layoutAttributes = (0..<collectionView!.numberOfItems(inSection: 0)).map { i in
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.size = itemSize
            attributes.frame = CGRect(origin: CGPoint(x: (itemSize.width + 10) * CGFloat(i), y: 0) , size: itemSize)
            return attributes
        }
    }

    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.row]
    }
    
    override var collectionViewContentSize : CGSize {
        let number = collectionView!.numberOfItems(inSection: 0)
        return CGSize(width: (collectionView!.frame.size.width / 2) * CGFloat(number), height: collectionView!.frame.size.height)
    }
    
}
