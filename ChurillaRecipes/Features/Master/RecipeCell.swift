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

    var recipeImageURL: URL? {
        didSet {
            guard let url = recipeImageURL else { return }
            recipeImageView.setImageWith(url)
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

    @IBOutlet fileprivate weak var recipeImageView: UIImageView!
    @IBOutlet fileprivate weak var recipeTitle: UILabel!
    @IBOutlet fileprivate weak var recipeDescription: UILabel!

}
