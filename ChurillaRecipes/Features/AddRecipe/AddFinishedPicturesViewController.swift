//
//  AddFinishedPicturesViewController.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 10/2/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import UIKit

internal final class AddFinishedPicturesViewController: UIViewController, ChurillaViewController {
    var viewModel: AddFinishedPicturesViewModel!
    
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBAction private func addButtonPressed(sender: AnyObject) {
        
    }
}
