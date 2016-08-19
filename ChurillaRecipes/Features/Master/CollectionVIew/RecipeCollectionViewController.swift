//
//  RecipeCollectionViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 7/20/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

internal final class RecipeCollectionViewController: UICollectionViewController, ChurillaViewController {

    var viewModel: RecipesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
   
        
    }
    
    private func setupBindings() {
        viewModel.configFinished?.startListening(self, event: { (finished) in
            self.getRecipes()
        })
        
        viewModel.loading.startListening(self) { [weak self] (loading) in
            if loading {
                self?.view.showActivitySpinner()
            } else {
                self?.view.removeActivitySpinner()
            }
        }
    }
    
    private func setupView() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addRecipe))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func addRecipe() {
        let model = viewModel.viewModelForAdding()
        let controller: AddRecipeViewController = AddRecipeViewController.parentStoryboard.instantiateViewController(model)
        controller.reloadTable = { [weak self] _ in
            // can remove when implement core data
            self?.getRecipes()
        }
        
        let navigation = UINavigationController(rootViewController: controller)
        presentViewController(navigation, animated: true, completion: nil)
    }
    
    private func getRecipes() {
        viewModel.retrieveAllRecipes(success: { [weak self] _ in
            self?.collectionView?.reloadData()
        }) { (error) in
            self.showAlert("Oops", message: error.userFacingDescription)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == RecipeDetailViewController.segueIdentifier {
            guard let
                nav = segue.destinationViewController as? UINavigationController,
                controller = nav.topViewController as? RecipeDetailViewController,
                idx = collectionView?.indexPathsForSelectedItems()?.first
                else {
                fatalError()
            }
            
            
            let model = viewModel.detailViewModel(withIndex: idx)
            controller.viewModel = model
        }
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsForSection(section)
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: RecipeCollectionViewCell = collectionView.dequeueCollectionCellForIndex(indexPath)
        let model = viewModel.viewModelForIndexPath(indexPath)
        cell.recipeImageURL = model.imageURL
        cell.recipeTitle = model.title
        return cell
    }

}
