//
//  ProgramsSectionItem.swift
//  workout
//
//  Created by Михаил on 25.03.2024.
//

import Foundation

enum ProgramsSectionItem {
    case trainingType(info: TrainingTypeViewModel)
    case programLevelType(info: ProgramLevelsViewModel)
    case targetType(info: TargetTypeViewModel)
    case otherType(info: OtherTypeViewModel)
}

extension ProgramsSectionItem {
    var id: String {
        switch self {
        case .trainingType:
            return "TrainingType"
            
        case .programLevelType:
            return "ProgramLevelType"
            
        case .targetType:
            return "targetType"
            
        case .otherType:
            return "otherType"
        }
    }
}
