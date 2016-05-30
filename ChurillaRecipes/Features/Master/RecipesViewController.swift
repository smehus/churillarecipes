//
//  RecipesViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/23/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit
import AFNetworking

internal final class RecipesViewController: UITableViewController, ChurillaViewController {
    
    var viewModel: RecipesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getRecipes()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == RecipeDetailViewController.segueIdentifier {
            guard let nav = segue.destinationViewController as? UINavigationController, controller = nav.topViewController as? RecipeDetailViewController else {
                fatalError()
            }
            
            
            if let idx = tableView.indexPathForSelectedRow {
                let model = viewModel.detailViewModel(withIndex: idx)
                controller.viewModel = model
            }
        }
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
    
    private func setupView() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addRecipe))
        navigationItem.rightBarButtonItem = addButton
    }

    private func getRecipes() {
        viewModel.retrieveAllRecipes(success: { [weak self] _ in
            self?.tableView.reloadData()
            }) { (error) in
                self.showAlert("Oops", message: error.userFacingDescription)
        }
    }
    
}

extension RecipesViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsForSection(section)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: RecipeCell = tableView.dequeueReusableCellForIndex(indexPath)
        let model = viewModel.viewModelForIndexPath(indexPath)
        cell.titleText = model.title
        cell.descriptionText = model.description
        cell.recipeImageURL = model.imageURL
        
        return cell
    }
    
}


