//
//  ExampleCollectionViewCell.swift
//  MediaLoader_Example
//
//  Created by Matias Fernandez on 4/14/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Photos

class ExampleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var representedAssetIdentifier: String!
    
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
}
