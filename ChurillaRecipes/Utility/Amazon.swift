//
//  Amazon.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/24/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit
import AmazonS3RequestManager

let Bucket = "churillarecipes"
let AccessKey = "AKIAJXTQYBC24IJQXKRQ"
let Secret = "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"

internal struct Amazon: ImageUploader {
    
    var baseUrl: String {
        return "https://s3-us-west-2.amazonaws.com/churillarecipes/"
    }
    
    let amazonS3Manager = AmazonS3RequestManager(bucket: Bucket,
                                                 region: .USWest2,
                                                 accessKey: AccessKey,
                                                 secret: Secret)
    
    
    init() {
        amazonS3Manager.setBucketACL(AmazonS3PredefinedACL.Public)
    }
    
    func uploadImages(images: [UIImage], title: String, completion: (urls: [String]) -> Void, failure: (reason: String) -> Void) {
        var imageUrls = [String]()
        for (index, image) in images.enumerate() {
            if let pngData = UIImagePNGRepresentation(image) {
                let path = "\(title.removeSpaces())_\(index).png"
               
                amazonS3Manager.putObject(pngData, destinationPath: path, acl: AmazonS3PredefinedACL.PublicReadOnly).responseS3Data({ (response) in
                    if response.result.isFailure {
                        failure(reason: response.result.description)
                    }
                    
                     imageUrls.append("\(self.baseUrl)\(path)")
                    if index == images.count - 1 && response.result.isSuccess {
                        completion(urls: imageUrls)
                    }
                })
            }
        }
    }
    
    func uploadImage(image: UIImage, title: String, completion: (url: String) -> Void, failure: (reason: String) -> Void) {
        
        if let pngData = UIImagePNGRepresentation(image) {
            let path = "\(title.removeSpaces()).png"
    
            amazonS3Manager.putObject(pngData, destinationPath: path, acl: AmazonS3PredefinedACL.PublicReadOnly).responseS3Data({ (response) in
                print("IMAGE UPLOAD RETURN")
                switch response.result {
                case .Success:
                    completion(url: "\(self.baseUrl)\(path)")
                case .Failure(let error):
                    failure(reason: error.localizedDescription)
                }
                
            })
        }
    }
    
    private func resizeImage(image: UIImage) -> UIImage {
        let size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.2, 0.2))
        let hasAlpha = false
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
}
