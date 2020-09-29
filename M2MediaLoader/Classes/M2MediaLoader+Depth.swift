//
//  MediaLoader+Depth.swift
//  LiveCollage
//
//  Created by Matias Fernandez on 26/09/2017.
//  Copyright © 2017 M2Media. All rights reserved.
//

import UIKit
import CoreImage
import AVFoundation

//MARK: Data and Depth retrieval

//Seps for using Depth:
// 1 - Get image properties asynchronously and check it has depth info
// 2 - Retrieve depth map
// 3 - Translate to disparity image
// 4 - Generate mask from disparity
// 5 - Generate background image
// 6 - Apply blend between original and background using mask

public extension M2MediaLoader {
   
    //MARK: CIIMage Depth Image
    /**
     Converts Image Data to Disparity Image
     
     - Parameter imageData: the image in Data format
     
     - Returns : a CIImage with disparity filter applied (Grayscale image)
     */
    func getDisparityImage(imageData: Data) -> CIImage? {
        //Create Depth Image
        guard let depthImage = CIImage(data: imageData, options:[CIImageOption.auxiliaryDepth: true]) else {
            return nil
        }
        return getDisparityFromDepthImage(depthImage: depthImage)
    }
    
    
    /**
     Analizes max and min values withing a disparity image for a given rect.
     
     - Parameter disparityImage: the CIImage to process
     - Parameter rect: CGRect
     
     - Returns: (min: Float, max: Float) result tuple
     */
    public func sampleDisparity(disparityImage: CIImage, rect: CGRect) -> (min: Float, max: Float){
        //Apply filter with the Sample Rect from the user's tap.
        let minMaxImage = disparityImage.clampedToExtent().applyingFilter("CIAreaMinMaxRed", parameters: [kCIInputExtentKey : CIVector(cgRect: rect)])
        //Four byte buffer to store single pixel value
        var pixel = [UInt8](repeatElement(0, count: 4))
        
        //Render the image to a 1x1 rect.
        CIContext().render(minMaxImage, toBitmap: &pixel, rowBytes: 4,
                           bounds: CGRect(x:0, y: 0, width:1, height:1),
                           format: CIFormat.RGBA8, colorSpace: nil)
        
        //The max is stored in the green channel. Min is in the red.
        return (min: Float(pixel[0]) / 255.0, max: Float(pixel[1]) / 255.0)
    }
    
    //Awful code. Fuck CFFoundation!!
    @available(iOS 11.0, *)
    /**
     
     */
    public func hasDepthInformation(info: [AnyHashable : Any]) -> Bool {
        guard let content = info[kCGImagePropertyFileContentsDictionary] as? [AnyHashable : Any] else {
            return false
        }
        let count = content[kCGImagePropertyImageCount] as? Int
        if count! < 1 {
            return false
        }
        guard let images = content[kCGImagePropertyImages] as? [Any] else {
            return false
        }
        
        guard let image = images[0] as? [AnyHashable: Any] else {
            return false
        }
        guard let auxilaryData = image[kCGImagePropertyAuxiliaryData] as? [Any] else {
            return false
        }
        guard let aux = auxilaryData[0] as? [AnyHashable: Any] else {
            return false
        }
        let dataType: CFString = aux[kCGImagePropertyAuxiliaryDataType] as! CFString
        if dataType == kCGImageAuxiliaryDataTypeDisparity {
            NSLog("Disparity data found!")
            return true
        }
        return false
    }
    
}

//MARK: Private Methods
extension M2MediaLoader {

    //Convert Depth Image to Disparity Image
    fileprivate func getDisparityFromDepthImage(depthImage: CIImage) -> CIImage? {
        let disparityImage = depthImage.applyingFilter("CIDepthToDisparity")
        return disparityImage
    }
}

