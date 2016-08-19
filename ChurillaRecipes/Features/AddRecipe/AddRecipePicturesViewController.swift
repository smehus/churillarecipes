//
//  AddRecipePicturesViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 10/1/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

internal final class AddRecipePicturesViewController: UIViewController, ChurillaViewController {
    
    internal enum Identifiers: String {
        case FinishedPicturesSegue = "FinishedPicturesSegue"
    }

    var viewModel: AddRecipePicturesViewModel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Identifiers.FinishedPicturesSegue.rawValue {
            guard let controller = segue.destinationViewController as? AddFinishedPicturesViewController else {
                return
            }
            
            controller.viewModel = viewModel.nextViewModel()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    
    @IBAction private func addButtonPressed(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            
            let action = UIAlertController(title: "", message: "", preferredStyle: .ActionSheet)
            let camera = UIAlertAction(title: "Take Photo", style: .Default) { (action) in
                picker.sourceType = .Camera
                self.presentViewController(picker, animated: true, completion: nil)
            }
            
            let libraray = UIAlertAction(title: "Library", style: .Default) { (action) in
                picker.sourceType = .PhotoLibrary
                self.presentViewController(picker, animated: true, completion: nil)
            }
            
            action.addAction(camera)
            action.addAction(libraray)
            presentViewController(action, animated: true, completion: nil)
        } else {
            picker.sourceType = .PhotoLibrary
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
}

extension AddRecipePicturesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true) {
            self.viewModel.uploadImage(image, completed: { [weak self] (result) in
                switch result {
                case .Success:
                    self?.collectionView.reloadData()
                case .Failure(let error):
                    self?.showAlert("Failed to upload image", message: error.userFacingDescription)
                }
            })
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension AddRecipePicturesViewController: UICollectionViewDelegate {
    
}

extension AddRecipePicturesViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsForSection(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: ImageCell = collectionView.dequeueCollectionCellForIndex(indexPath)
        let model = viewModel.viewModelForIndexPath(indexPath)
        cell.image = model.imageUrl
        
        return cell
    }
}
