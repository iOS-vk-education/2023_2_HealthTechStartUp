//
//  DayService.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import Foundation
import Firebase

protocol DayServiceDescription {
    func getDaySchedule(on date: Date, completion: @escaping (Result<[WorkoutDay], CustomError>) -> Void)
    func getDayResults(on date: Date, completion: @escaping (Result<[WorkoutDay], CustomError>) -> Void)
}

final class DayService: DayServiceDescription {
    static let shared: DayServiceDescription = DayService()
    private let db = Firestore.firestore()

    private init() {}

//    func getDaySchedule(on date: Date, completion: @escaping (Result<[(workout: Workout, indexOfDay: Int)], CustomError>) -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            let workoutDays = MockSchedule.mockSchedule.daysOfWeek[4]
//            let result: Result<[(workout: Workout, indexOfDay: Int)], CustomError> = .success(workoutDays) // .failure(.unknownError)
//            completion(result)
//        }
//    }
    
    func getDaySchedule(on date: Date, completion: @escaping (Result<[WorkoutDay], CustomError>) -> Void) {
//        guard let userUID = Auth.auth().currentUser?.uid else {
//            completion(.failure(.invalidUser))
//            return
//        }

        let userUID = "xWIxNStVG3LdO2TnMN8W"

        db.collection("user")
            .document(userUID)
            .getDocument(as: MyUser.self) { result in
                switch result {
                case .success(let user):
                    var programIDs: [DocumentReference] = []
                    user.schedule?[0].programs.forEach { partOfWorkout in  // date instead of 0
                        programIDs.append(partOfWorkout.programID)
                    }
                    let group = DispatchGroup()
                    var workoutDays: [WorkoutDay] = []

                    for programReference in programIDs {
                        group.enter()
                        programReference.getDocument(as: Workout.self) { result in
                            defer {
                                group.leave()
                            }

                            switch result {
                            case .success(let workout):
                                workoutDays.append(.init(workout: workout, indexOfDay: 0))  // get index from db

                            case .failure(let error):
                                print(error.localizedDescription, "kek")
                            }
                        }
                    }

                    group.notify(queue: .main) {
                        completion(.success(workoutDays))
                    }

                case .failure(let error):
                    print(error.localizedDescription, "lol")
                }
            }
    }
    
    func getDayResults(on date: Date, completion: @escaping (Result<[WorkoutDay], CustomError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            let workoutDays = MockSchedule.mockSchedule.daysOfWeek[4]
//            let result: Result<[WorkoutDay], CustomError> = .success(workoutDays)
            let result: Result<[WorkoutDay], CustomError> = .failure(.unknownError)
            completion(result)
        }
    }
}
