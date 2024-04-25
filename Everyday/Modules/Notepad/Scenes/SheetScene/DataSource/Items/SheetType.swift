//
//  SheetType.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//

import UIKit

enum SheetType {
    case camera(model: CameraModel)
    case conditionChoice(model: ConditionChoiceModel)
    case heartRateVariability(model: HeartRateVariabilityModel)
    case weightMeasurement(model: WeightMeasurementModel)
}

struct CameraModel {
    var image: UIImage?
    var status: String = "Photo wasn't saved."
}

struct ConditionChoiceModel {
    var condition: Condition?
    var status: String = "Condition wasn't chosen."
}

struct HeartRateVariabilityModel {
    var heartRateVariability: HeartRateVariability?
    var status: String = "No data saved."
}

struct WeightMeasurementModel {
    var weight: Double?
    var status: String = "Weight wasn't measured."
}

enum Condition: String, CaseIterable {
    case tired = "figure.roll"
    case ok = "medal"
    case great = "trophy"
}

struct HeartRateVariability {
    var heartRate: Double? = 0.0
    var status: String = "No heart rate"
}
