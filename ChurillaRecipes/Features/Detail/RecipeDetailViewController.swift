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

    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var recipeDescriptionLabel: UILabel!
    
    private var camera: Camera?
    private var finishedPicturesController: FinishedPicturesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == FinishedPicturesViewController.segueIdentifier {
            guard let controller = segue.destinationViewController as? FinishedPicturesViewController else {
                fatalError()
            }
            finishedPicturesController = controller
            controller.images = viewModel.finishedImages
            
        } else if segue.identifier == InstructionsViewController.segueIdentifier {
            guard let controller = segue.destinationViewController as? InstructionsViewController else {
                fatalError()
            }
            
            controller.images = viewModel.recipeImages
        }
    }
    
    private func setupView() {
        camera = Camera(delegate: self)
        recipeTitleLabel.text = viewModel.recipeTitle
    }

    @IBAction private func addFinishedImage(sender: AnyObject) {
        camera?.attemptCameraAccessAndOpen { [weak self] (pickedPhoto) in
            self?.uploadAndUpdate(pickedPhoto)
        }
    }
    
    private func uploadAndUpdate(photo: UIImage) {
        viewModel.uploadImageAndUpdateRecipe(photo, completed: { [weak self] _ in
            
            }) { (message) in
                self.showAlert("Oops", message: message)
        }
    }
}
