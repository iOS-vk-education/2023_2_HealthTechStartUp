//
//  Domain.swift
//  Everyday
//
//  Created by Alexander on 16.04.2024.
//

import Foundation

// MARK: - NotepadModel

struct NotepadModel {
    var schedule: [NewWorkout]?
    let history: [NewWorkout]?
}

struct NewWorkout {  // Workout
    let workoutName: String
    let dayName: String
    let dayIndex: Int?
    var sets: [NewTrainingSet]
    
    init() {
        workoutName = ""
        dayName = ""
        dayIndex = nil
        sets = []
    }
    
    init(workoutName: String, dayName: String, dayIndex: Int?, sets: [NewTrainingSet]) {
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

struct NewTrainingSet {  // TrainingSet
    let name: String
    var exercises: [NewExercise]
    
    init(dtoModel: DayServiceSetElement) {
        name = dtoModel.name
        exercises = dtoModel.exercises.map { .init(dtoModel: $0) }
    }
}

struct NewExercise {  // Exercise
    let name: String
    var result: String
    
    init(dtoModel: DayServiceExerciseElement) {
        name = dtoModel.name
        result = dtoModel.result
    }
}

// MARK: - ExtraModel

struct ExtraModel {  // ExtraModel
    let imageURL: String?
    let condition: Int?
    let weight: Double?
}

struct NewWorkoutProgress {  // WorkoutProgress
    let workout: NewWorkout
    let extra: ExtraModel?
}
