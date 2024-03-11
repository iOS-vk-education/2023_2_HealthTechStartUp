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
    }
}

// struct Schedule: Codable {
//    let dayOfWeek: [Day]
// }

struct Day: Codable, Hashable {
    let dayOfWeek: String
    let programs: [PartOfWokout]
}

struct PartOfWokout: Codable, Hashable {
    let programID: DocumentReference
    let indexOfDay: Int
}

struct WorkoutDay {
    var workout: Workout
    let indexOfDay: Int
}

struct Schedule1 {
    let daysOfWeek: [[(workout: Workout, indexOfDay: Int)]]  // 7 elements (arrays) = 7 days
}

struct MockSchedule {
    static let mockSchedule = Schedule1(daysOfWeek: [
        [],
        [],
        [],
        [],
        [(workout: Mock.mockWorkouts[0], indexOfDay: 0), (workout: Mock.mockWorkouts[1], indexOfDay: 0)],
        [(workout: Mock.mockWorkouts[2], indexOfDay: 0)],
        [(workout: Mock.mockWorkouts[0], indexOfDay: 1)]
    ])
}
