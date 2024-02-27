//
//  GenderModel.swift
//  welcome
//
//  Created by Михаил on 14.02.2024.
//

// MARK: - GenderModel

enum Gender {
    case male, female, other
    
    var description: String {
            switch self {
            case .male: return "male"
            case .female: return "female"
            case .other: return "other"
            }
        }
    
    static func from(description: String) -> Gender? {
           switch description.lowercased() {
           case "male": return .male
           case "female": return .female
           case "other": return .other
           default: return nil
           }
       }
}

struct GenderData {
    let gender: Gender
}
