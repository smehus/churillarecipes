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
    
    @IBOutlet fileprivate weak var titleTextField: UITextField!
    @IBOutlet fileprivate weak var descriptionTextField: UITextView!
    @IBOutlet fileprivate weak var textViewPlaceholder: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.RecipePictures.rawValue {
            let model = viewModel.nextViewModel()
            guard let controller = segue.destination as? AddRecipePicturesViewController else { return }
            controller.viewModel = model
        }
    }
    
    fileprivate func setupView() {
        let saveButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextStep))
        navigationItem.rightBarButtonItem = saveButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
        
        titleTextField.addTarget(self, action: #selector(titleTextUpdate), for: UIControlEvents.editingChanged)
    }
    
    @objc fileprivate func titleTextUpdate(_ textField: UITextField) {
        viewModel.titleString = textField.text ?? ""
    }
    
    @objc fileprivate func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func nextStep() {
        performSegue(withIdentifier: Identifiers.RecipePictures.rawValue, sender: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension AddRecipeViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.descriptionString = textView.text
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewPlaceholder.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewPlaceholder.isHidden = textView.text.characters.count > 0
    }
}





