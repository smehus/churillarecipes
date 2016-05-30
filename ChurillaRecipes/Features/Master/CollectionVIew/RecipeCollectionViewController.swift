//
//  RecipeCollectionViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 7/20/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

internal final class RecipeCollectionViewController: UICollectionViewController, ChurillaViewController {

    var viewModel: RecipesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: CGRectGetWidth(collectionView!.bounds), height: 100)
        }
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        cell.contentView.backgroundColor = (indexPath.row % 2 == 0) ? UIColor.greenColor() : UIColor.cyanColor()
    
        return cell
    }

}
