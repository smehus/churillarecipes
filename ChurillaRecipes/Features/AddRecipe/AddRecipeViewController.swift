//
//  AddRecipeViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/9/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit


internal final class AddRecipeViewController: UIViewController, ChurillaViewController {

    var viewModel: AddRecipeViewModel!
    var reloadTable: (() -> Void)?
    
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextField: UITextView!
    @IBOutlet private weak var textViewPlaceholder: UILabel!
    @IBOutlet private weak var collectionVIew: UICollectionView!
    @IBOutlet private weak var takePicButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setPictureButton()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Horizontal
        collectionVIew.setCollectionViewLayout(flowLayout, animated: true)
    }
    
    private func setupView() {
        let saveButton = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: #selector(saveRecipe))
        navigationItem.rightBarButtonItem = saveButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
        
        titleTextField.addTarget(self, action: #selector(titleTextUpdate), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    @objc private func titleTextUpdate(textField: UITextField) {
        viewModel.titleString = textField.text ?? ""
        setPictureButton()
    }
    
    @objc private func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func saveRecipe() {
        viewModel.saveRecipe({ [weak self] _ in
            self?.reloadTable!()
            self?.showAlertWithDismiss("Success!", message: "You Did It!")
            }) { [weak self] (err) in
                
                switch err {
                case .ValidationError:
                    self?.showAlert("Oops", message: err.userFacingDescription)
                default:
                    self?.showAlertWithDismiss("Ruh Roh", message: "You Failed :(")
                }
        }
    }
    
    @IBAction private func picButtonClicked(sender: AnyObject) {
        
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            picker.sourceType = .Camera
        } else {
            picker.sourceType = .PhotoLibrary
        }
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setPictureButton() {
        takePicButton.enabled = viewModel.pictureButtonActive
        takePicButton.titleLabel?.textColor = viewModel.pictureButtonColor
    }
}

extension AddRecipeViewController: UITextViewDelegate {
    
    func textViewDidChange(textView: UITextView) {
        viewModel.descriptionString = textView.text
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textViewPlaceholder.hidden = true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textViewPlaceholder.hidden = textView.text.characters.count > 0
    }
}

extension AddRecipeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        dismissViewControllerAnimated(true) { 
            self.viewModel.uploadImage(image, completed: { [weak self] (result) in
                switch result {
                case .Success:
                    self?.collectionVIew.reloadData()
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

extension AddRecipeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height)
    }
}





