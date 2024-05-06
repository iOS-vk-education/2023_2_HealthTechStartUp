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
    
    var description: String {
        switch self {
        case .camera:
            return "Add photo"
        case .conditionChoice:
            return "Note how you feel"
        case .heartRateVariability:
            return "Heart rate variability"
        case .weightMeasurement:
            return "Weight"
        }
    }
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

enum Condition: Int, CaseIterable {
    case tired
    case ok
    case great
    
    var imageName: String {
        switch self {
        case .tired:
            return "figure.roll"
        case .ok:
            return "medal"
        case .great:
            return "trophy"
        }
    }
}

struct HeartRateVariability {
    var heartRate: Double? = 0.0
}
