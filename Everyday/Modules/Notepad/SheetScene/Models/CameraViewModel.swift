//
//  CameraViewModel.swift
//  Everyday
//
//  Created by Alexander on 06.05.2024.
//

import UIKit

struct CameraViewModel {
    let retakePhotoImage: UIImage?
    
    init() {
        let retakePhotoImageName = "arrow.triangle.2.circlepath.camera"
        let retakePhotoImage = UIImage(systemName: retakePhotoImageName, withConfiguration: Configurations.large)
        
        self.retakePhotoImage = retakePhotoImage
    }
}

private extension CameraViewModel {
    struct Configurations {
        static let large = UIImage.SymbolConfiguration(textStyle: .largeTitle)
    }
}
