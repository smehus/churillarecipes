//
//  ImageUploader.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/24/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

internal protocol ImageUploader {
    
    var baseUrl: String { get }
    
    func uploadImage(image: UIImage, title: String, completion: (url: String) -> Void, failure: (reason: String) -> Void)
    
    func uploadImages(images: [UIImage], title: String, completion: (urls: [String]) -> Void, failure: (reason: String) -> Void)
}
