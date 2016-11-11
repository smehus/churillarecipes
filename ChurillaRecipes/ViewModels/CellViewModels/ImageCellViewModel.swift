//
//  ImageCellViewModel.swift
//  ChurillaRecipes
//
//  Created by Scott Mehus on 6/27/16.
//  Copyright © 2016 Scott Mehus. All rights reserved.
//

import Foundation

internal struct ImageCellViewModel: CellViewModel {
    
    var imageUrl: URL? {
        return image.imageURL
    }
    
    fileprivate let image: Image
    typealias ObjectType = Image
    init(object: ObjectType) {
        self.image = object
    }
}
