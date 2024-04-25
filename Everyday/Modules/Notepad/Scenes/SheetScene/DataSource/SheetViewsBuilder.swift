//
//  SheetViewsBuilder.swift
//  Everyday
//
//  Created by Alexander on 25.04.2024.
//

import UIKit

protocol SheetViewsBuilderDescription {
    func build(with input: SheetType, output: SheetActionOutput?) -> UIView
}

final class SheetViewsBuilder: SheetViewsBuilderDescription {
    func build(with input: SheetType, output: SheetActionOutput?) -> UIView {
        switch input {
        case .camera(let cameraModel):
            return CameraView(image: cameraModel.image, output: output)
        case .conditionChoice(let conditionChoiceViewModel):
            return ConditionChoiceView(condition: conditionChoiceViewModel.condition, output: output)
        case .heartRateVariability:
            return EmptyStateView()
        case .weightMeasurement(let weightMeasurementViewModel):
            return WeightMeasurementView(weight: weightMeasurementViewModel.weight, output: output)
        }
    }
}
