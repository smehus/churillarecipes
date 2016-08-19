//
//  AddRecipeViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/9/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

internal enum Identifiers: String {
    case RecipePictures = "RecipePicturesSegue"
}

internal final class AddRecipeViewController: UIViewController, ChurillaViewController {

    var viewModel: AddRecipeViewModel!
    var reloadTable: (() -> Void)?
    
    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var descriptionTextField: UITextView!
    @IBOutlet private weak var textViewPlaceholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Identifiers.RecipePictures.rawValue {
            let model = viewModel.nextViewModel()
            guard let controller = segue.destinationViewController as? AddRecipePicturesViewController else { return }
            controller.viewModel = model
        }
    }
    
    private func setupView() {
        let saveButton = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextStep))
        navigationItem.rightBarButtonItem = saveButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
        
        titleTextField.addTarget(self, action: #selector(titleTextUpdate), forControlEvents: UIControlEvents.EditingChanged)
    }
    
    @objc private func titleTextUpdate(textField: UITextField) {
        viewModel.titleString = textField.text ?? ""
    }
    
    @objc private func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc private func nextStep() {
        performSegueWithIdentifier(Identifiers.RecipePictures.rawValue, sender: nil)
    }
    
//    @objc private func saveRecipe() {
//        viewModel.saveRecipe({ [weak self] _ in
//            self?.reloadTable!()
//            self?.showAlertWithDismiss("Success!", message: "You Did It!")
//        }) { [weak self] (err) in
//                
//                switch err {
//                case .ValidationError:
//                    self?.showAlert("Oops", message: err.userFacingDescription)
//                default:
//                    self?.showAlertWithDismiss("Ruh Roh", message: "You Failed :(")
//                }
//        }
//    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
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





