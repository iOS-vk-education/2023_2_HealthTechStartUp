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
    let schedule: DayServiceSchedule?
    let history: [DayServiceHistoryElement]?
}

struct DayServiceSchedule: Decodable {
    let monday: [DayServiceProgramElement]
    let tuesday: [DayServiceProgramElement]
    let wednesday: [DayServiceProgramElement]
    let thursday: [DayServiceProgramElement]
    let friday: [DayServiceProgramElement]
    let saturday: [DayServiceProgramElement]
    let sunday: [DayServiceProgramElement]

    init() {
        monday = []
        tuesday = []
        wednesday = []
        thursday = []
        friday = []
        saturday = []
        sunday = []
    }
}

struct DayServiceProgramElement: Decodable {
    let indexOfCurrentDay: Int
    let programID: DocumentReference
}

struct DayServiceHistoryElement: Codable {
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

extension DayServiceSchedule {
    func toDictionary() -> [String: Any] {
        return [
            "monday": monday.map { $0.toDictionary() },
            "tuesday": tuesday.map { $0.toDictionary() },
            "wednesday": wednesday.map { $0.toDictionary() },
            "thursday": thursday.map { $0.toDictionary() },
            "friday": friday.map { $0.toDictionary() },
            "saturday": saturday.map { $0.toDictionary() },
            "sunday": sunday.map { $0.toDictionary() }
        ]
    }
}

extension DayServiceProgramElement {
    func toDictionary() -> [String: Any] {
        return [
            "indexOfCurrentDay": indexOfCurrentDay,
            "programID": programID.path
        ]
    }
}

extension DayServiceHistoryElement {
    func toDictionary() -> [String: Any] {
        let formatter = ISO8601DateFormatter()
        let dateString = formatter.string(from: date)

        return [
            "date": dateString,
            "historyID": historyID.path
        ]
    }
}
