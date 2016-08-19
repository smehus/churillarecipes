//
//  StackedParallaxLayout.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 7/20/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

struct LayoutConstants {
    struct Cell {
        static let standardHeight: CGFloat = 100
        static let featuredHeight: CGFloat = 280
    }
}

internal final class StackedParallaxLayout: UICollectionViewLayout {

    /// Amount to scroll for featured cell to change
    let dragOffset: CGFloat = 180.0
    
    var layoutCache = [UICollectionViewLayoutAttributes]()
    
    
    /* Return the size of all the content in the collection view */
    override func collectionViewContentSize() -> CGSize {
        let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height + dragOffset)
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepareLayout() {
        layoutCache.removeAll(keepCapacity: false)
        
        let standardHeight = LayoutConstants.Cell.standardHeight
        let featuredHeight = LayoutConstants.Cell.featuredHeight
        
        var frame = CGRectZero
        var y: CGFloat = 0
        
        layoutCache = (0..<numberOfItems).map { itemIndex in
            
            let indexPath = NSIndexPath(forItem: itemIndex, inSection: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            
            /// This stacks the cell before on top of the cell after
            /// zIndex places the view on the z axis - so above or below another view
            attributes.zIndex = itemIndex
            
            /// Set the standard height - will override if its the featured cell
            var height = standardHeight
            
            /**
             *  if the indexPath is the featured item - aka the top cell
             */
            if indexPath.item == featuredItemIndex {
                
                /// will be between 0 & 100
                /// 100 * 0-1 aka -> 100 * 0.4 = 40
                /// percentage of standard height
                let yOffset = standardHeight * nextItemPercentageOffset
                1
                // This will push up the current featured cell up
                // until it reaches 100 points above the current top of the tablevview
                // So half the cell is above the screen & half is still on screen
                // The cell below it will grow from 100 to 200 and cover the bottom on screen half of the featured cell, in turn becoming featured
                y = collectionView!.contentOffset.y - yOffset
                
                
                // Set the height to the full height - featured height
                height = featuredHeight
                
                
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                let maxY = y + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset, 0)
                y = maxY - height
            }
            
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            y = CGRectGetMaxY(frame)
            return attributes
            
        }
        
    }
    
    /* Return all attributes in the cache whose frame intersects with the rect passed to the method */
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in layoutCache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    /* Return true so that the layout is continuously invalidated as the user scrolls */
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let itemIndex = round(proposedContentOffset.y / dragOffset)
        let yOffset = itemIndex * dragOffset
        return CGPoint(x: 0, y: yOffset)
    }
}

// MARK: - Helper Methods
extension StackedParallaxLayout {
    
    /// Round to the nearest index e.x. 250 / 180 = 1.38 rounded to 1. Index = 1 - the index will continue to grow as you scroll
    var featuredItemIndex: Int {
        return max(0, Int(collectionView!.contentOffset.y / dragOffset))
    }
    
    /// Returns a value between 0 and 1 that represents how close the next cell is to becoming the featured cell
    
    var nextItemPercentageOffset: CGFloat {
        
        /// Percentage of how close the offest (drag) is to our total action drag amount aka 180
        /// 500 / 1000 = 0.5
        let percentage = (collectionView!.contentOffset.y / dragOffset)
        
        /// the index that shows up at the top of the view
        let featuredIndex = CGFloat(featuredItemIndex)
        
        /// standardized to be between 0 & 1
        let standardizedPercentage = percentage - featuredIndex

        return standardizedPercentage
    }
    
    var width: CGFloat {
        return CGRectGetWidth(collectionView!.bounds)
    }
    
    var height: CGFloat {
        return CGRectGetHeight(collectionView!.bounds)
    }
    
    var numberOfItems: Int {
        return collectionView!.numberOfItemsInSection(0)
    }
    
}
