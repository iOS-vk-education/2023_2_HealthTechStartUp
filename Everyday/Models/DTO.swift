//
//  DTO.swift
//  Everyday
//
//  Created by Alexander on 16.04.2024.
//

import Foundation
import Firebase

// MARK: - DayServiceUser

struct DayServiceUser: Decodable {
    let schedule: [DayServiceScheduleElement]
    let history: [DayServiceHistoryElement]
}

struct DayServiceScheduleElement: Decodable {
    let programs: [DayServiceProgramElement]
}

struct DayServiceProgramElement: Decodable {
    let indexOfCurrentDay: Int
    let programID: DocumentReference
}

struct DayServiceHistoryElement: Decodable {
    let date: Date
    let historyID: DocumentReference
}

// MARK: - DayServiceProgram

struct DayServiceProgram: Decodable {
    let name: String
    let days: [DayServiceDayElement]
}

struct DayServiceDayElement: Decodable {
    let name: String
    let sets: [DayServiceSetElement]
}

struct DayServiceSetElement: Decodable {
    let name: String
    let exercises: [DayServiceExerciseElement]
}

struct DayServiceExerciseElement: Decodable {
    let name: String
    let result: String
}

// MARK: - DayServiceHistory

struct DayServiceHistory: Decodable {
    let workouts: [DayServiceWorkout]
    let extra: DayServiceExtra?
}

struct DayServiceWorkout: Decodable {
    let programName: String
    let programDay: DayServiceDayElement
}

struct DayServiceExtra: Decodable {
    let imageURL: String?
    let condition: Int?
    let weight: Double?
}
