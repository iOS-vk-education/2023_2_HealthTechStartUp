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
    case exerciseTimer(model: ExerciseTimerModel)
    case timer(model: TimerModel)
    
    var description: String {
        switch self {
        case .camera:
            return "Sheet_Camera_description".localized
        case .conditionChoice:
            return "Sheet_ConditionChoice_description".localized
        case .heartRateVariability:
            return "Sheet_HeartRateVariability_description".localized
        case .weightMeasurement:
            return "Sheet_WeightMeasurement_description".localized
        case .exerciseCounter:
            return "Sheet_ExerciseCounter_description".localized
        case .exerciseTimer:
            return "Sheet_ExerciseTimer_description".localized
        case .timer:
            return "Sheet_Timer_description".localized
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

struct ExerciseTimerModel {
    var exercise: Exercise
}

struct TimerModel {
    var seconds: Int
}
