//
//  Camera.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation
import UIKit

internal final class Camera: NSObject {
    
    private let picker = UIImagePickerController()
    private var photoPicked: ((pickedPhoto: UIImage) -> Void)?
    private let controller: UIViewController
    
    init(delegate: UIViewController) {
        controller = delegate
        super.init()
    }
    
    func attemptCameraAccessAndOpen(completed: (pickedPhoto: UIImage) -> Void) {
        self.photoPicked = completed
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = .Camera
        } else {
            picker.sourceType = .PhotoLibrary
        }
        
        picker.allowsEditing = true
        picker.delegate = self
        controller.presentViewController(picker, animated: true, completion: nil)
    }
}

extension Camera: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        photoPicked?(pickedPhoto: image)
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}