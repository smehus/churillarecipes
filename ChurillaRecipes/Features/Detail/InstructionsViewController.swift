//
//  InstructionsViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/25/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

internal final class InstructionsViewController: UIViewController, SegueIdentifiable {
    
    var images = [Image]()

    @IBOutlet private weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = HorizontalLayout()
    }
}

extension InstructionsViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: ImageCell = collectionView.dequeueCollectionCellForIndex(indexPath)
        let model = ImageCellViewModel(object: images[indexPath.row])
        cell.image = model.imageUrl
        return cell
    }
}

extension InstructionsViewController: UICollectionViewDelegate {
    
    
}
