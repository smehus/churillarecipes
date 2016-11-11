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
    
    func uploadImage(_ image: UIImage, title: String, completion: @escaping (_ url: String) -> Void, failure: @escaping (_ reason: String) -> Void)
    
    func uploadImages(_ images: [UIImage], title: String, completion: @escaping (_ urls: [String]) -> Void, failure: @escaping (_ reason: String) -> Void)
}
