//
//  MediaType.swift
//  MediaLoader
//
//  Created by Matias Fernandez on 27/09/2020.
//

import Foundation
import Photos


public enum M2MediaType {
    
    case ALL_PHOTOS
    case PANORAMA
    case HDR_PHOTO
    case SCREENSHOT
    case LIVE_IMAGE
    case DEPTH_IMAGE
    case ALL_VIDEOS
    case VIDEO_STREAMED
    case VIDEO_HFR
    case VIDEO_TIMELAPSE
    case ALL_AUDIOS
    case AUDIO
    
    
    public var name: String {
        switch self {
            case .ALL_PHOTOS:
                return "All Photos"
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
            case .ALL_VIDEOS:
                return "All Video"
            case .VIDEO_STREAMED:
                return "Video Streamed"
            case .VIDEO_HFR:
                return "Video HFR"
            case .VIDEO_TIMELAPSE:
                return "Video Timelapse"
            case .ALL_AUDIOS:
                return "All Audio"
            case .AUDIO:
                return "Audio"
        }
    }
    
    public var type: PHAssetMediaType {
        switch self {
        case .ALL_PHOTOS, .PANORAMA, .HDR_PHOTO, .SCREENSHOT, .LIVE_IMAGE, .DEPTH_IMAGE:
                return PHAssetMediaType.image
        case .ALL_VIDEOS, .VIDEO_STREAMED,.VIDEO_HFR, .VIDEO_TIMELAPSE:
                return PHAssetMediaType.video
        case .ALL_AUDIOS, .AUDIO:
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
            case .ALL_PHOTOS, .ALL_VIDEOS, .ALL_AUDIOS:
                return PHAssetMediaSubtype.init()
        }
    }
}
