//
//  SheetType.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit

enum SheetType {
    case camera(viewModel: CameraViewModel)
    case weightMeasurement(viewModel: WeightMeasurementViewModel)
    case conditionChoice(viewModel: ConditionChoiceViewModel)
    case heartRateVariability(viewModel: HeartRateVariabilityViewModel)
}

struct CameraViewModel {
    var image: UIImage?
    var status: String = "Photo wasn't saved."
}

struct WeightMeasurementViewModel {
    var weight: Double?
    var status: String = "Weight wasn't measured."
}

struct ConditionChoiceViewModel {
    var condition: Condition?
    var status: String = "Condition wasn't chosen."
}

struct HeartRateVariabilityViewModel {
    var heartRateVariability: HeartRateVariability?
    var status: String = "No data saved."
}

enum Condition: String, CaseIterable {
    case bad = "Bad"
    case ok = "Ok"
    case great = "Great"
}

struct HeartRateVariability {
    var heartRate: Double? = 0.0
    var status: String = "No heart rate"
}
