//
//  DayService.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import Foundation

protocol DayServiceDescription {
    func getDaySchedule(completion: @escaping (Result<[(workout: Workout, indexOfDay: Int)], CustomError>) -> Void)
    func getDayResults(on date: Date, completion: @escaping (Result<[(workout: Workout, indexOfDay: Int)], CustomError>) -> Void)
}

final class DayService: DayServiceDescription {
    static let shared: DayServiceDescription = DayService()

    private init() {}

    func getDaySchedule(completion: @escaping (Result<[(workout: Workout, indexOfDay: Int)], CustomError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let workoutDays = MockSchedule.mockSchedule.daysOfWeek[4]
            let result: Result<[(workout: Workout, indexOfDay: Int)], CustomError> = .success(workoutDays) // .failure(.unknownError)
            completion(result)
        }
    }
    
    func getDayResults(on date: Date, completion: @escaping (Result<[(workout: Workout, indexOfDay: Int)], CustomError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let workoutDays = MockSchedule.mockSchedule.daysOfWeek[4]
//            let result: Result<[(workout: Workout, indexOfDay: Int)], CustomError> = .success(workoutDays)
            let result: Result<[(workout: Workout, indexOfDay: Int)], CustomError> = .failure(.unknownError)
            completion(result)
        }
    }
}
