//
//  ExampleCollectionViewController.swift
//  MediaLoader_Example
//
//  Created by Matias Fernandez on 4/14/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Photos
import M2MediaLoader

private let reuseIdentifier = "identifier"

class ExampleCollectionViewController: UICollectionViewController {

    var result: PHFetchResult<PHAsset>!
    var currentOption: M2MediaType!
    var selected: PHAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func load(_ option: M2MediaType) {
        currentOption = option
        result = M2MediaLoader.shared().getResources(self, mediaType: option)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if result == nil {
            result = M2MediaLoader.shared().getResoures(self, type: currentOption.type, subtype: currentOption.subtype)
        }
        collectionView.reloadData()
    }
}

extension ExampleCollectionViewController {
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ExampleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ExampleCollectionViewCell else {
            fatalError("unexpected cell in collection view")
        }
        
        let asset = result[indexPath.row]
        
        
        // Request an image for the asset from the PHCachingImageManager.
        
        cell.representedAssetIdentifier = asset.localIdentifier
        M2MediaLoader.shared().getAsset(asset: asset,
                                      forSize: cell.imageView.frame.size) { (image, info) in
            // The cell may have been recycled by the time this handler gets called;
            // set the cell's thumbnail image only if it's still showing the same asset.
            if cell.representedAssetIdentifier == asset.localIdentifier && image != nil {
                cell.imageView.image = image
            }
        }
    
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selected = result[indexPath.row]
        self.performSegue(withIdentifier: "detail", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detail") {
            let destination = segue.destination
            if(destination .isKind(of: ExampleDetailViewController.classForCoder())) {
                
                if (selected != nil) {
                    (destination as! ExampleDetailViewController).load(selected!)
                }
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}

extension ExampleCollectionViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: result)
            else { return }
        
        // Change notifications may be made on a background queue. Re-dispatch to the
        // main queue before acting on the change as we'll be updating the UI.
        DispatchQueue.main.sync {
            // Hang on to the new fetch result.
            result = changes.fetchResultAfterChanges
            if changes.hasIncrementalChanges {
                // If we have incremental diffs, animate them in the collection view.
                guard let collectionView = self.collectionView else { fatalError() }
                collectionView.performBatchUpdates({
                    // For indexes to make sense, updates must be in this order:
                    // delete, insert, reload, move
                    if let removed = changes.removedIndexes, !removed.isEmpty {
                        collectionView.deleteItems(at: removed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let inserted = changes.insertedIndexes, !inserted.isEmpty {
                        collectionView.insertItems(at: inserted.map({ IndexPath(item: $0, section: 0) }))
                    }
                    if let changed = changes.changedIndexes, !changed.isEmpty {
                        collectionView.reloadItems(at: changed.map({ IndexPath(item: $0, section: 0) }))
                    }
                    changes.enumerateMoves { fromIndex, toIndex in
                        collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
                                                to: IndexPath(item: toIndex, section: 0))
                    }
                })
            } else {
                // Reload the collection view if incremental diffs are not available.
                collectionView!.reloadData()
            }
//            resetCachedAssets()
        }
    }
}

