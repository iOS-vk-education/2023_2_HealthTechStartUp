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
    let dayIndex: Int
    var sets: [NewTrainingSet]
}

struct NewTrainingSet {  // TrainingSet
    let name: String
    var exercises: [NewExercise]
}

struct NewExercise {  // Exercise
    let name: String
    let description: String
    var result: String
}

// MARK: - ExtraModel

struct ExtraModel {  // ExtraModel
    let imageURL: String?
    let condition: Int?
    let weight: Double?
}
