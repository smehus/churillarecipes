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
    
    fileprivate func setupBindings() {
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
    
    fileprivate func setupView() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addRecipe))
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
        present(navigation, animated: true, completion: nil)
    }
    
    fileprivate func getRecipes() {
        viewModel.retrieveAllRecipes(success: { [weak self] _ in
            self?.collectionView?.reloadData()
        }) { (error) in
            self.showAlert("Oops", message: error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == RecipeDetailViewController.segueIdentifier {
            guard let
                nav = segue.destination as? UINavigationController,
                let controller = nav.topViewController as? RecipeDetailViewController,
                let idx = collectionView?.indexPathsForSelectedItems?.first
                else {
                fatalError()
            }
            
            
            let model = viewModel.detailViewModel(withIndex: idx)
            controller.viewModel = model
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsForSection(section)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecipeCollectionViewCell = collectionView.dequeueCollectionCellForIndex(indexPath)
        let model = viewModel.viewModelForIndexPath(indexPath)
        cell.recipeImageURL = model.imageURL
        cell.recipeTitle = model.title
        return cell
    }

}
