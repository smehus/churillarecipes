//
//  RecipeCollectionViewCell.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 8/21/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

internal final class RecipeCollectionViewCell: UICollectionViewCell, ReusableCell {
    
    var recipeImageURL: NSURL? {
        didSet {
            guard let url = recipeImageURL else {
                return
            }
            
            recipeImageView.setImageWithURL(url)
        }
    }
    
    
    var recipeTitle: String? {
        didSet {
            recipeTitleLabel.text = recipeTitle
        }
    }
    
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var imageOverlay: UIView!
    @IBOutlet private weak var recipeImageView: UIImageView!
}

extension RecipeCollectionViewCell {
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        
        let standardHeight = LayoutConstants.Cell.standardHeight
        let featuredHeight = LayoutConstants.Cell.featuredHeight
        
        ///  determines the percentage of the height change from the standard height to the featured height
        let delta = 1 - ((featuredHeight - CGRectGetHeight(frame)) / (featuredHeight - standardHeight))
        
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
        imageOverlay.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        
        let scale = max(delta, 0.5)
        recipeTitleLabel.transform = CGAffineTransformMakeScale(scale, scale)
        
    }
}
