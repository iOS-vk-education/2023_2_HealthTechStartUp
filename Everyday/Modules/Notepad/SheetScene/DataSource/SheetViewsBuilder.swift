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
        case .camera(let model):
            return CameraView(image: model.image, output: output)
        case .conditionChoice(let model):
            return ConditionChoiceView(condition: model.condition, output: output)
        case .heartRateVariability:
            return UIView()
        case .weightMeasurement(let model):
            return WeightMeasurementView(weight: model.weight, output: output)
        case .exerciseCounter(let model):
            return ExerciseCounterView(exercise: model.exercise, output: output)
        case .exerciseTimer(let model):
            return ExerciseTimerView(exercise: model.exercise, output: output)
        }
    }
}
