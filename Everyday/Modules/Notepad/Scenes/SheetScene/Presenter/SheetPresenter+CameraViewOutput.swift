//
//  SheetPresenter+CameraViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import UIKit

extension SheetPresenter: CameraViewOutput {
    func didTapSaveButton(with image: UIImage?) {
        print("[DEBUG] camera save button")
        let cameraModel = CameraModel(image: image)
        let moduleType = SheetType.camera(model: cameraModel)
        moduleOutput?.setResult(moduleType, at: 0)
        router.dismissSheet()
    }
    
    func didTapCameraCloseButton() {
        router.dismissSheet()
    }
}
