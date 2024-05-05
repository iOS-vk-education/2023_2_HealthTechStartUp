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
    let result: String
    
    init(domainModel: Exercise) {
        name = domainModel.name
        result = domainModel.result
    }
}

// MARK: - DayServiceHistory

struct DayServiceHistory: Codable {
    let workout: DayServiceWorkout
    let extra: DayServiceExtra?
//    
//    init(domainModel: WorkoutProgress) {
//        workout = .init(domainModel: domainModel.workout)
//        extra = .init(domainModel: domainModel.extra)
//    }
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
