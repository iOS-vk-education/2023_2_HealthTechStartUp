//
//  SheetActionOutput.swift
//  Everyday
//
//  Created by Alexander on 25.04.2024.
//

import UIKit

protocol SheetActionOutput: CameraViewOutput,
                            ConditionChoiceViewOutput,
                            WeightMeasurementViewOutput,
                            HeartRateVariabilityViewOutput,
                            ExerciseCounterViewOutput {}

// MARK: - Camera

protocol CameraViewOutput: AnyObject {
    func didTapSaveButton(with image: UIImage?)
    func didTapCameraCloseButton()
}

// MARK: - ConditionChoice

protocol ConditionChoiceViewOutput: AnyObject {
    func didTapSaveButton(with condition: Condition?)
    func didTapConditionChoiceCloseButton()
}

// MARK: - HeartRateVariability

protocol HeartRateVariabilityViewOutput: AnyObject {
    func didTapSaveButton(with heartRateVariability: HeartRateVariability?)
    func didTapHeartRateVariabilityCloseButton()
}

// MARK: - WeightMeasurement

protocol WeightMeasurementViewOutput: AnyObject {
    func didTapSaveButton(with weight: Double?)
    func didTapWeightMeasurementCloseButton()
}

// MARK: - ExerciseCounter

protocol ExerciseCounterViewOutput: AnyObject {
    func didTapSaveButton(with exercise: Exercise)
    func didTapExerciseCounterCloseButton()
}
