//
//  File.swift
//  
//
//  Created by admin on 28/03/2024.
//

import Foundation
import AVFoundation

extension AVCaptureDevice {
    static var videoDevices: [AVCaptureDevice] {
        return AVCaptureDevice.devices(for: AVMediaType.video)
    }
}
