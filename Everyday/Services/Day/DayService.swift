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
    
    func getDaySchedule(on date: Date, completion: @escaping (Result<[WorkoutDay], CustomError>) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(.failure(.unknownError))
            return
        }

        db.collection(Constants.userCollection)
            .document(userUID)
            .getDocument(as: MyUser.self) { result in
                switch result {
                case .success(let user):
                    guard let schedule = user.schedule else {
                        completion(.failure(.unknownError))
                        return
                    }
                    var programIDs: [DocumentReference] = []
                    let dayIndex = CalendarService.shared.getWeekdayIndex(from: date)
                    let dayPrograms = schedule[dayIndex]
                    dayPrograms.programs.forEach { partOfWorkout in
                        programIDs.append(partOfWorkout.programID)
                    }
                    let group = DispatchGroup()
                    var workoutDays: [WorkoutDay] = Array(repeating: WorkoutDay(), count: programIDs.count)

                    for indexOfProgram in 0..<programIDs.count {
                        group.enter()
                        programIDs[indexOfProgram].getDocument(as: Workout.self) { result in
                            defer {
                                group.leave()
                            }

                            switch result {
                            case .success(let workout):
                                let indexOfDay = dayPrograms.programs[indexOfProgram].indexOfDay
                                workoutDays[indexOfProgram] = .init(workout: workout, indexOfDay: indexOfDay)
                                
                            case .failure:
                                completion(.failure(.unknownError))
                            }
                        }
                    }

                    group.notify(queue: .main) {
                        completion(.success(workoutDays))
                    }

                case .failure:
                    completion(.failure(.unknownError))
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

// MARK: - Constants

private extension DayService {
    struct Constants {
        static let userCollection = "user"
    }
}
