//
//  Domain.swift
//  Everyday
//
//  Created by Alexander on 16.04.2024.
//

import UIKit

// MARK: - NotepadModel

struct NotepadModel {
    var schedule: [Workout]?
    let history: [Workout]?
}

struct Workout {
    let workoutName: String
    let dayName: String
    let dayIndex: Int?
    var sets: [TrainingSet]
    
    init() {
        workoutName = ""
        dayName = ""
        dayIndex = nil
        sets = []
    }
    
    init(workoutName: String, dayName: String, dayIndex: Int?, sets: [TrainingSet]) {
        self.workoutName = workoutName
        self.dayName = dayName
        self.dayIndex = dayIndex
        self.sets = sets
    }
    
    init(dtoHistoryWorkout: DayServiceWorkout) {
        workoutName = dtoHistoryWorkout.programName
        dayName = dtoHistoryWorkout.programDay.name
        dayIndex = nil
        sets = dtoHistoryWorkout.programDay.sets.map { .init(dtoModel: $0) }
    }
}

struct TrainingSet {
    let name: String
    var exercises: [Exercise]
    
    init(dtoModel: DayServiceSetElement) {
        name = dtoModel.name
        exercises = dtoModel.exercises.map { .init(dtoModel: $0) }
    }
}

struct Exercise {
    let name: String
    var result: String
    
    init(dtoModel: DayServiceExerciseElement) {
        name = dtoModel.name
        result = dtoModel.result
    }
}

// MARK: - ExtraModel

struct WorkoutProgress {
    let workout: Workout
    var extra: ExtraModel?
}

struct ExtraModel {
    let image: UIImage?
    let condition: Int?
    let weight: Double?
}
