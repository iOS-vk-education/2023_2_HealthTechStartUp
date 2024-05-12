//
//  Preview.swift
//  AI_Everyday
//
//  Created by Михаил on 08.05.2024.
//

import UIKit
import AVFoundation

class Preview: UIView {
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Layer is not of type AVCaptureVideoPreviewLayer")
        }
        return layer
    }
    
    var session: AVCaptureSession? {
        get { return videoPreviewLayer.session }
        set { videoPreviewLayer.session = newValue }
    }
    
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
