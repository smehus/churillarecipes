//
//  AddFinishedPicturesViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 10/2/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

internal final class AddFinishedPicturesViewController: UIViewController, ChurillaViewController {
    var viewModel: AddFinishedPicturesViewModel!
    
    @IBOutlet fileprivate weak var infoLabel: UILabel!
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    @IBAction fileprivate func addButtonPressed(_ sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            let action = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Take Photo", style: .default) { (action) in
                picker.sourceType = .camera
                self.present(picker, animated: true, completion: nil)
            }
            
            let libraray = UIAlertAction(title: "Library", style: .default) { (action) in
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true, completion: nil)
            }
            
            action.addAction(camera)
            action.addAction(libraray)
            present(action, animated: true, completion: nil)
        } else {
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
    }
    

    @IBAction fileprivate func saveButtonPressed(_ sender: AnyObject) {
        viewModel.save { (worked) in
            if worked {
                self.showAlert("SUCCESS", message: nil)
            } else {
                self.showAlert("FAILURE", message: nil)
            }
        }
    }
    
    fileprivate func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
    }
}

extension AddFinishedPicturesViewController: UICollectionViewDelegate {
    
}

extension AddFinishedPicturesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsForSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCell = collectionView.dequeueCollectionCellForIndex(indexPath)
        let model = viewModel.viewModelForIndexPath(indexPath)
        cell.image = model.imageUrl
        
        return cell
    }
}

extension AddFinishedPicturesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismiss(animated: true) {
            self.viewModel.uploadImage(image, completed: { [weak self] (result) in
                switch result {
                case .success:
                    self?.collectionView.reloadData()
                case .failure(let error):
                    self?.showAlert("Failed to upload image", message: error.localizedDescription)
                }
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
