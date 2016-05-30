//
//  RecipeCell.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit
import AFNetworking

internal final class RecipeCell: UITableViewCell, ReusableCell {

    var recipeImageURL: NSURL = NSURL() {
        didSet {
            recipeImageView.setImageWithURL(recipeImageURL)
        }
    }
    
    var titleText: String? {
        didSet {
            recipeTitle.text = titleText
        }
    }
    
    
    var descriptionText: String? {
        didSet {
            recipeDescription.text = descriptionText
        }
    }

    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var recipeTitle: UILabel!
    @IBOutlet private weak var recipeDescription: UILabel!

}
