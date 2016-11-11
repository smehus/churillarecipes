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
    
    fileprivate let picker = UIImagePickerController()
    fileprivate var photoPicked: ((_ pickedPhoto: UIImage) -> Void)?
    fileprivate let controller: UIViewController
    
    init(delegate: UIViewController) {
        controller = delegate
        super.init()
    }
    
    func attemptCameraAccessAndOpen(_ completed: @escaping (_ pickedPhoto: UIImage) -> Void) {
        self.photoPicked = completed
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.allowsEditing = true
        picker.delegate = self
        controller.present(picker, animated: true, completion: nil)
    }
}

extension Camera: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        photoPicked?(image)
        controller.dismiss(animated: true, completion: nil)
    }
}
