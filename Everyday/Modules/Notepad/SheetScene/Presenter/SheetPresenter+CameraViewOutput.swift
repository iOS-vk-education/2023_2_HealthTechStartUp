//
//  SheetPresenter+CameraViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import UIKit

extension SheetPresenter: CameraViewOutput {
    func didTapSaveButton(with image: UIImage?) {
        let cameraModel = CameraModel(image: image)
        let moduleType = SheetType.camera(model: cameraModel)
        moduleOutput?.setResult(moduleType)
        router.dismissSheet()
    }
    
    func didTapCameraCloseButton() {
        router.dismissSheet()
    }
}
