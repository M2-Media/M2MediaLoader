//
//  MediaType.swift
//  MediaLoader
//
//  Created by Matias Fernandez on 27/09/2020.
//

import Foundation
import Photos


public enum MediaType {
    
    case PANORAMA
    case HDR_PHOTO
    case SCREENSHOT
    case LIVE_IMAGE
    case DEPTH_IMAGE
    case VIDEO_STREAMED
    case VIDEO_HFR
    case VIDEO_TIMELAPSE
    case AUDIO
    
    
    public var name: String {
        switch self {
            case .PANORAMA:
                return "Panoramas"
            case .HDR_PHOTO:
                return "HDR Photos"
            case .SCREENSHOT:
                return "Screenshots"
            case .LIVE_IMAGE:
                return "Live Image"
            case .DEPTH_IMAGE:
                return "Image w/Depth"
            case .VIDEO_STREAMED:
                return "Video Streamed"
            case .VIDEO_HFR:
                return "Video HFR"
            case .VIDEO_TIMELAPSE:
                return "Video Timelapse"
            case .AUDIO:
                return "Audio"
        }
    }
    
    public var type: PHAssetMediaType {
        switch self {
            case .PANORAMA, .HDR_PHOTO, .SCREENSHOT, .LIVE_IMAGE, .DEPTH_IMAGE:
                return PHAssetMediaType.image
            case .VIDEO_STREAMED,.VIDEO_HFR, .VIDEO_TIMELAPSE:
                return PHAssetMediaType.video
            case .AUDIO:
                return PHAssetMediaType.audio
        }
    }
    
    public var subtype: PHAssetMediaSubtype {
        switch self {
            case .PANORAMA:
                return PHAssetMediaSubtype.photoPanorama
            case .HDR_PHOTO:
                return PHAssetMediaSubtype.photoHDR
            case .SCREENSHOT:
                return PHAssetMediaSubtype.photoScreenshot
            case .LIVE_IMAGE:
                return PHAssetMediaSubtype.photoLive
            case .DEPTH_IMAGE:
                return PHAssetMediaSubtype.photoDepthEffect
            case .VIDEO_STREAMED:
                return PHAssetMediaSubtype.videoStreamed
            case .VIDEO_HFR:
                return PHAssetMediaSubtype.videoHighFrameRate
            case .VIDEO_TIMELAPSE:
                return PHAssetMediaSubtype.videoTimelapse
            case .AUDIO:
                return PHAssetMediaSubtype.videoTimelapse
        }
    }
}
