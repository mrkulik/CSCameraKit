//
//  File.swift
//  
//
//  Created by admin on 28/03/2024.
//

import Foundation
import UIKit
import Photos

public enum CaptureContent {
    case imageData(Data)
    case image(UIImage)
    case asset(PHAsset)
}

extension CaptureContent {
    public var asImage: UIImage? {
        switch self {
            case let .image(image): return image
            case let .imageData(data): return UIImage(data: data)
            case let .asset(asset):
                if let data = getImageData(fromAsset: asset) {
                    return UIImage(data: data)
                } else {
                    return nil
            }
        }
    }
    
    public var asData: Data? {
        switch self {
            case let .image(image): return image.jpegData(compressionQuality: 1.0)
            case let .imageData(data): return data
            case let .asset(asset): return getImageData(fromAsset: asset)
        }
    }
    
    private func getImageData(fromAsset asset: PHAsset) -> Data? {
        var imageData: Data?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageData(for: asset, options: options) { data, _, _, _ in
            
            imageData = data
        }
        return imageData
    }
}
