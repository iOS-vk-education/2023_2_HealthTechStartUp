//
//  User.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct MyUser: Codable {
    @DocumentID var id: String?
    let age: String
    let email: String
    let firstname: String
    let gender: String
    let lastname: String
    let nickname: String
    let weight: String
    let schedule: [Day]?
    let history: [HistoryDay]?
    
    init() {
        id = nil
        age = ""
        email = ""
        firstname = ""
        gender = ""
        lastname = ""
        nickname = ""
        weight = ""
        schedule = nil
        history = nil
    }
}

struct HistoryDay: Codable, Hashable {
    let date: Date
    let historyID: [PartOfWokout]
}

struct Day: Codable, Hashable {
    let dayOfWeek: String
    let programs: [PartOfWokout]
}

struct PartOfWokout: Codable, Hashable {
    let programID: DocumentReference
    let indexOfDay: Int
}

struct WorkoutDay: Comparable {
    var workout: Workout
    let indexOfDay: Int
    
    init() {
        workout = Workout()
        indexOfDay = 0
    }
    
    init(workout: Workout, indexOfDay: Int) {
        self.workout = workout
        self.indexOfDay = indexOfDay
    }
    
    static func < (lhs: WorkoutDay, rhs: WorkoutDay) -> Bool {
        return lhs.workout < rhs.workout
    }
    
    static func == (lhs: WorkoutDay, rhs: WorkoutDay) -> Bool {
        return lhs.workout == rhs.workout
    }
}

struct Schedule1 {
    let daysOfWeek: [[WorkoutDay]]  // 7 elements (arrays) = 7 days
}

struct MockSchedule {
    static let mockSchedule = Schedule1(daysOfWeek: [
        [],
        [],
        [],
        [],
        [.init(workout: Mock.mockWorkouts[0], indexOfDay: 0), .init(workout: Mock.mockWorkouts[1], indexOfDay: 0)],
        [.init(workout: Mock.mockWorkouts[2], indexOfDay: 0)],
        [.init(workout: Mock.mockWorkouts[0], indexOfDay: 1)]
    ])
}
