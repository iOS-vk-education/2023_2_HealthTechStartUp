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
}

struct ConditionChoiceModel {
    var condition: Condition?
}

struct HeartRateVariabilityModel {
    var heartRateVariability: HeartRateVariability?
}

struct WeightMeasurementModel {
    var weight: Double?
}

enum Condition: String, CaseIterable {
    case tired = "figure.roll"
    case ok = "medal"
    case great = "trophy"
}

struct HeartRateVariability {
    var heartRate: Double? = 0.0
}
