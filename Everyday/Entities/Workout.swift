//
//  Workout.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Workout: Codable, Comparable {
    @DocumentID var id: String?
    let name: String
    var days: [DayOfWorkout]
    
    init() {
        id = nil
        name = ""
        days = []
    }
    
    init(id: String? = nil, name: String, days: [DayOfWorkout]) {
        self.id = id
        self.name = name
        self.days = days
    }

    static func < (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.name < rhs.name
    }
}

struct DayOfWorkout: Codable, Hashable {
    var name: String
    var sets: [TrainingSet]
}

struct TrainingSet: Codable, Hashable {
    var name: String
    var exercises: [Exercise]
}

struct Exercise: Codable, Hashable {
    let name: String
    let description: String
    var result: String  // change for enum ResultOfExercise, problem: set 0 by default?
}

// not in use yet
enum ResultOfExercise {
    case reps(Int, Int)  // associated values: number of reps, extra weight (zero by default or another case)
    case time(Int, Int, Int)  // associated values: minutes, seconds, extra weight (zero by default or another case)
}

struct Mock {
    
    static let mockWorkouts = [
        Workout(name: "Фулбоди", days: [
            DayOfWorkout(name: "День 1", sets: [
                TrainingSet(name: "", exercises: [
                    Exercise(name: "Подтягивания", description: "", result: "10"),
                    Exercise(name: "Отжимания", description: "", result: "20")]),
                TrainingSet(name: "", exercises: [
                    Exercise(name: "Пресс", description: "", result: "11"),
                    Exercise(name: "Спина", description: "", result: "22")])]),
            DayOfWorkout(name: "День 2", sets: [
                TrainingSet(name: "", exercises: [
                    Exercise(name: "епуапук", description: "", result: "10 раз"),
                    Exercise(name: "куцпкцпц", description: "", result: "20 раз")]),
                TrainingSet(name: "", exercises: [
                    Exercise(name: "кцпук", description: "", result: "1 минута"),
                    Exercise(name: "куцпукп", description: "", result: "20 раз")])])]),
        Workout(name: "Руки", days: [
            DayOfWorkout(name: "День 1", sets: [
                TrainingSet(name: "", exercises: [
                    Exercise(name: "Фокусы", description: "", result: "10 попугаев")])])]),
        Workout(name: "Ноги", days: [
            DayOfWorkout(name: "День 1", sets: [
                TrainingSet(name: "", exercises: [
                    Exercise(name: "Штанга", description: "", result: "8 раз")])])]),
        Workout(name: "Кардио", days: [
            DayOfWorkout(name: "День 1", sets: [
                TrainingSet(name: "", exercises: [
                    Exercise(name: "Jumping Jacks", description: "", result: "20 раз")])])])
    ]
}
