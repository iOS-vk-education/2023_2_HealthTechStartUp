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
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "monday": monday,
            "tuesday": tuesday,
            "wednesday": wednesday,
            "thursday": thursday,
            "friday": friday,
            "saturday": saturday,
            "sunday": sunday
        ]
    }
}

struct DayServiceProgramElement: Decodable {
    let indexOfCurrentDay: Int
    let programID: DocumentReference
}

struct DayServiceHistoryElement: Decodable {
    let date: Date
    let historyID: DocumentReference
    
    var dictionaryRepresentation: [String: Any] {
        return [
            "date": date,
            "historyID": historyID
        ]
    }
}

// MARK: - DayServiceProgram

struct DayServiceProgram: Decodable {
    let name: String
    let days: [DayServiceDayElement]
}

struct DayServiceDayElement: Codable {
    let name: String
    let sets: [DayServiceSetElement]
    
    init(domainModel: Workout) {
        name = domainModel.dayName
        sets = domainModel.sets.map { .init(domainModel: $0) }
    }
}

struct DayServiceSetElement: Codable {
    let name: String
    let exercises: [DayServiceExerciseElement]
    
    init(domainModel: TrainingSet) {
        name = domainModel.name
        exercises = domainModel.exercises.map { .init(domainModel: $0) }
    }
}

struct DayServiceExerciseElement: Codable {
    let name: String
    let type: Int
    let result: String
    
    init(domainModel: Exercise) {
        name = domainModel.name
        type = domainModel.type.rawValue
        result = domainModel.result
    }
}

// MARK: - DayServiceHistory

struct DayServiceHistory: Codable {
    let workout: DayServiceWorkout
    let extra: DayServiceExtra?
    
    init(workout: DayServiceWorkout, extra: DayServiceExtra? = nil) {
        self.workout = workout
        self.extra = extra
    }
}

struct DayServiceWorkout: Codable {
    let programName: String
    let programDay: DayServiceDayElement
    
    init(domainModel: Workout) {
        programName = domainModel.workoutName
        programDay = .init(domainModel: domainModel)
    }
}

struct DayServiceExtra: Codable {
    let imageURL: String?
    let condition: Int?
    let weight: Double?
}
