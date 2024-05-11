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
    case exerciseCounter(model: ExerciseCounterModel)
    
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
        case .exerciseCounter:
            return "Exercise counter"
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

struct ExerciseCounterModel {
    var exercise: Exercise
}
