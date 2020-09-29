//
//  MediaLoader.swift
//  MediaLoader
//
//  Created by Matias Fernandez on 8/20/17.
//  Copyright © 2017 M2Media. All rights reserved.
//

import UIKit
import Photos
import ImageIO
import AVFoundation
import CoreImage
import Foundation
import PhotosUI

public struct ImageData {
    public var data: Data?
    public var info: [AnyHashable: Any]?
    public var orientation: UIImage.Orientation?
}

public class M2MediaLoader {
    
    static let instance = M2MediaLoader()
    
    fileprivate var manager = PHCachingImageManager()
    
    public static func shared() -> M2MediaLoader {
        return instance
    }
    
    
    //MARK - Photo Library
    public func getResources(_ delegate: PHPhotoLibraryChangeObserver, mediaType: M2MediaType) -> PHFetchResult<PHAsset> {
        return getResoures(delegate, type: mediaType.type, subtype: mediaType.subtype)
    }
    
    
    public func getResoures(_ delegate: PHPhotoLibraryChangeObserver, type: PHAssetMediaType,
                                    subtype: PHAssetMediaSubtype) -> PHFetchResult<PHAsset> {
        stopCaching()
        PHPhotoLibrary.shared().register(delegate)
        
        let fetchOptions = PHFetchOptions()
        //TODO: offer sorting options & combine asset types & subtypes
        if subtype.rawValue != 0 {
            fetchOptions.predicate = NSPredicate(format: "((mediaSubtype & %d) != 0)", subtype.rawValue)
        }
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return PHAsset.fetchAssets(with: type, options: fetchOptions)
    }
    
    //Gets image from PHAsset.
    //Returns image in callback
    public func getAsset(asset: PHAsset, forSize: CGSize, resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Swift.Void) {
        // Request an image for the asset from the PHCachingImageManager.
        let options = PHImageRequestOptions()
        options.resizeMode = .fast
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.isSynchronous = false
        options.progressHandler =  {  (progress, error, stop, info) in
            print("progress: \(progress)")
        }
        //TODO: use Cloud
        manager.requestImage(for: asset, targetSize: forSize, contentMode: .aspectFill,
                             options: options, resultHandler: resultHandler)
    }
    
    public func stopCaching() {
        manager.stopCachingImagesForAllAssets()
    }
}


//MARK: Editing retrieval
extension M2MediaLoader {
    
    //Gets asset enabled for editing
    func getAssetForEdition(asset: PHAsset) {
        // Get the input from the asset
        let options = PHContentEditingInputRequestOptions()
        asset.requestContentEditingInput(with: options) { input, info in
            _ = input?.fullSizeImageURL
        }
    }
    
    //Gets image data from PHAsset
    public func getImageData(asset: PHAsset, resultHandler: @escaping (ImageData) -> Swift.Void) {
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.version = PHImageRequestOptionsVersion.original
        options.isNetworkAccessAllowed = true
        
        manager.requestImageData(for: asset, options: options) { (imageData, dataType, orientation, info) in
            
            guard let data = imageData?.CFData() else {
                resultHandler(ImageData(data: nil, info: nil, orientation: nil))
                return

            }
            let properties = self.imagePropertiesFromImageData(imageData: data) as? [AnyHashable: Any]
            resultHandler(ImageData(data: imageData, info: properties, orientation: orientation))
            
        }
    }
    
    //Get images properties
    func imagePropertiesFromImageData(imageData: CFData) -> CFDictionary? {
        NSLog("Getting image properties")
        if let cgImageSource = CGImageSourceCreateWithData(imageData, nil) {
            
            if let cgImageProperties = CGImageSourceCopyProperties(cgImageSource, nil) {
                NSLog("Image properties found!")
                return cgImageProperties
            }
        }
        NSLog("No image properties found")
        return nil
    }
    
    func saveEditedAsset(input: PHContentEditingInput, jpegData: Data, adjustmentData: PHAdjustmentData) {
        //TODO: Save image
    }
    
}
