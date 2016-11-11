//
//  RecipeDetailViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

internal final class RecipeDetailViewController: UIViewController, ChurillaViewController {
    
    var viewModel: RecipeDetailViewModel!

    @IBOutlet fileprivate weak var recipeTitleLabel: UILabel!
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    @IBOutlet fileprivate weak var recipeDescriptionLabel: UILabel!
    
    fileprivate var camera: Camera?
    fileprivate var finishedPicturesController: FinishedPicturesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == FinishedPicturesViewController.segueIdentifier {
            guard let controller = segue.destination as? FinishedPicturesViewController else {
                fatalError()
            }
            finishedPicturesController = controller
            controller.images = viewModel.finishedImages
            
        } else if segue.identifier == InstructionsViewController.segueIdentifier {
            guard let controller = segue.destination as? InstructionsViewController else {
                fatalError()
            }
            
            controller.images = viewModel.recipeImages
        }
    }
    
    fileprivate func setupView() {
        camera = Camera(delegate: self)
        recipeTitleLabel.text = viewModel.recipeTitle
    }

    @IBAction fileprivate func addFinishedImage(_ sender: AnyObject) {
        camera?.attemptCameraAccessAndOpen { [weak self] (pickedPhoto) in
            self?.uploadAndUpdate(pickedPhoto)
        }
    }
    
    fileprivate func uploadAndUpdate(_ photo: UIImage) {
        viewModel.uploadImageAndUpdateRecipe(photo, completed: { [weak self] _ in
            
            }) { [weak self] (message) in
                self?.showAlert("Oops", message: message)
        }
    }
}
