//
//  ImageCell.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/25/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit
import AFNetworking

internal final class ImageCell: UICollectionViewCell, ReusableCell {
    
    var image: NSURL? {
        didSet {
            guard let url = image else {
                return
            }
            
            imageView.setImageWithURL(url, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    @IBOutlet private weak var imageView: UIImageView!
}
