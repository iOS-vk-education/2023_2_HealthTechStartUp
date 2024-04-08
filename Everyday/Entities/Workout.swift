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
    var result: String
}
