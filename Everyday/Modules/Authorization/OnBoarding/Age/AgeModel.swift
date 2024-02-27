//
//  AgeModel.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import Foundation

// MARK: - GenderModel

enum Age {
    case small, young, adult, old
    
    var description: String {
            switch self {
            case .small: return "17 - 24"
            case .young: return "25 - 34"
            case .adult: return "35 - 54"
            case .old: return "55+"
            }
        }
    
    static func from(description: String) -> Age? {
            switch description {
            case "17 - 24": return .small
            case "25 - 34": return .young
            case "35 - 54": return .adult
            case "55+": return .old
            default: return nil
            }
        }
}

struct AgeData {
    let age: Age
}
