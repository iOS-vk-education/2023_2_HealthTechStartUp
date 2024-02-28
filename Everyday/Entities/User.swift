//
//  User.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import Foundation

struct User {
    let info: String  // change for several properies: name, weight, etc.
    let schedule: Schedule
}

struct Schedule {
    let daysOfWeek: [[(workout: Workout, indexOfDay: Int)]]  // 7 elements (arrays) = 7 days
}

struct MockSchedule {
    
    static let mockSchedule = Schedule(daysOfWeek: [
        [],
        [],
        [],
        [],
        [(workout: Mock.mockWorkouts[0], indexOfDay: 0), (workout: Mock.mockWorkouts[1], indexOfDay: 0)],
        [(workout: Mock.mockWorkouts[2], indexOfDay: 0)],
        [(workout: Mock.mockWorkouts[0], indexOfDay: 1)]
    ])
}
