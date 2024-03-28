//
//  File.swift
//  
//
//  Created by admin on 28/03/2024.
//

import Foundation

public enum CaptureError: Error {
    case noImageData
    case invalidImageData
    case noVideoConnection
    case noSampleBuffer
    case assetNotSaved
}
