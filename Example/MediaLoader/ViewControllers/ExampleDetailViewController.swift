//
//  ExampleDetailViewController.swift
//  MediaLoader_Example
//
//  Created by Matias Fernandez on 27/09/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Photos
import MediaLoader


class ExampleDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var asset: PHAsset!
    
    
    func load(_ asset: PHAsset!) {
        self.asset = asset
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        MediaLoader.shared().getAsset(asset: self.asset, forSize: imageView.frame.size) { [self] (image, info) in
            self.imageView.image = image
        }
    }
}
