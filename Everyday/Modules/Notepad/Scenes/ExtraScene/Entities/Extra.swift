//
//  Extra.swift
//  Everyday
//
//  Created by Alexander on 09.04.2024.
//

import Foundation

enum ExtraViewType: String, CaseIterable {
    case photo = "Add photo"
    case state = "Note how you feel"
    case heart = "Heart rate variability"
    case weight = "Weight"
}
/*
struct WorkoutProgress: Codable {
    let history: [HistoryWorkout]
    let extra: Extra?
    
    init() {
        history = []
        extra = nil
    }
}

struct HistoryWorkout: Codable {
    let workoutName: String
    let workoutDay: DayOfWorkout
}

struct Extra: Codable {
    let imageURL: String?
    let condition: Int?
    let weight: Double?
}
*/
