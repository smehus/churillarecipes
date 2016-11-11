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
    
    var image: Foundation.URL? {
        didSet {
            guard let url = image else {
                return
            }
            
            imageView.setImageWith(url, placeholderImage: UIImage(named: "placeholder"))
        }
    }
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
}
