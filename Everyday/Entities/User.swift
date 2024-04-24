//
//  User.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//
/*
import Foundation
import Firebase
import FirebaseFirestoreSwift

struct NotepadUser: Codable {
    @DocumentID var id: String?
    let schedule: [Day]?
    let history: [HistoryDay]?
    
    init() {
        id = nil
        schedule = nil
        history = nil
    }
}

struct HistoryDay: Codable, Hashable {
    let date: Date
    let historyID: [PartOfWokout]
}

struct HistoryElement: Codable {
    let date: Date
    let historyID: DocumentReference
}

struct Day: Codable, Hashable {
    let dayOfWeek: String
    let programs: [PartOfWokout]
}

struct PartOfWokout: Codable, Hashable {
    let programID: DocumentReference
    let indexOfDay: Int
}

struct WorkoutDay: Codable, Comparable {
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
*/
