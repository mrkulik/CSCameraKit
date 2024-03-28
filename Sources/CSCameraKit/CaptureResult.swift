//
//  File.swift
//  
//
//  Created by admin on 28/03/2024.
//

import Foundation
import UIKit
import Photos

public enum CaptureResult {
    case success(content: CaptureContent)
    case failure(Error)
    
    init(_ image: UIImage) {
        self = .success(content: .image(image))
    }
    
    init(_ data: Data) {
        self = .success(content: .imageData(data))
    }
    
    init(_ asset: PHAsset) {
        self = .success(content: .asset(asset))
    }
    
    var imageData: Data? {
        if case let .success(content) = self {
            return content.asData
        } else {
            return nil
        }
    }
}
