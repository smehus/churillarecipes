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
        let _ = amazonS3Manager.setBucketACL(PredefinedACL.bucketOwnerFullControl)
    }
    
    func uploadImages(_ images: [UIImage], title: String, completion: @escaping (_ urls: [String]) -> Void, failure: @escaping (_ reason: String) -> Void) {
        var imageUrls = [String]()
        for (index, image) in images.enumerated() {
            if let pngData = UIImagePNGRepresentation(image) {
                let path = "\(title.removeSpaces())_\(index).png"
               
                amazonS3Manager.upload(pngData, to: path, acl: PredefinedACL.publicReadOnly).responseS3Data(completion: { (response) in
                    if response.result.isFailure {
                        failure(response.result.description)
                    }
                    
                     imageUrls.append("\(self.baseUrl)\(path)")
                    if index == images.count - 1 && response.result.isSuccess {
                        completion(imageUrls)
                    }
                })
            }
        }
    }
    
    func uploadImage(_ image: UIImage, title: String, completion: @escaping (_ url: String) -> Void, failure: @escaping (_ reason: String) -> Void) {
        
        if let pngData = UIImagePNGRepresentation(image) {
            let path = "\(title.removeSpaces()).png"
    
            amazonS3Manager.upload(pngData, to: path, acl: PredefinedACL.publicReadOnly).responseS3Data(completion: { (response) in
                print("IMAGE UPLOAD RETURN")
                switch response.result {
                case .success:
                    completion("\(self.baseUrl)\(path)")
                case .failure(let error):
                    failure(error.localizedDescription)
                }
                
            })
        }
    }
    
    fileprivate func resizeImage(_ image: UIImage) -> UIImage {
        let size = image.size.applying(CGAffineTransform(scaleX: 0.2, y: 0.2))
        let hasAlpha = false
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
    
}
