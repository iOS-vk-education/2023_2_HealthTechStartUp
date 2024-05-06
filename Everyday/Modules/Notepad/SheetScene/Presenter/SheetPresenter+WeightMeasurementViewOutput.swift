//
//  SheetPresenter+WeightMeasurementViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import Foundation

extension SheetPresenter: WeightMeasurementViewOutput {
    func didTapSaveButton(with weight: Double?) {
        let weightMeasurementModel = WeightMeasurementModel(weight: weight)
        let moduleType = SheetType.weightMeasurement(model: weightMeasurementModel)
        moduleOutput?.setResult(moduleType, at: 3)
        router.dismissSheet()
    }
    
    func didTapWeightMeasurementCloseButton() {
        router.dismissSheet()
    }
}
