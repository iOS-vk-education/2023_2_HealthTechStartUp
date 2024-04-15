//
//  SheetPresenter+CameraViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import UIKit

protocol CameraViewOutput: AnyObject {
    func didLoadCameraView(with image: UIImage?)
    func didProcessImage(_ image: UIImage?)
}

extension SheetPresenter: CameraViewOutput {
    func didLoadCameraView(with image: UIImage? = nil) {
//        let viewModel = WeightMeasurementViewModel(value: weight)
//        contentView?.configure(with: viewModel)
    }
    
    func didProcessImage(_ image: UIImage?) {
        let cameraModel: CameraModel = .init(
            image: image,
            status: "New image set"
        )
        moduleType = .camera(model: cameraModel)
    }
}