//
//  DayService.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import Foundation
import Firebase

protocol DayServiceDescription {
    func getDaySchedule(on date: Date, completion: @escaping (Result<[Workout], CustomError>) -> Void)
    func getDayResults(on date: Date, completion: @escaping (Result<[Workout], CustomError>) -> Void)
    func postProgress(_ progress: WorkoutProgress, completion: @escaping (CustomError?) -> Void)
}

final class DayService: DayServiceDescription {
    static let shared: DayServiceDescription = DayService()
    private let db = Firestore.firestore()

    private init() {}
    
    // MARK: - GET
    
    func getDaySchedule(on date: Date, completion: @escaping (Result<[Workout], CustomError>) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(.failure(.unknownError))
            return
        }

        db.collection(Constants.userCollection)
            .document(userUID)
            .getDocument(as: DayServiceUser.self) { result in
                switch result {
                case .success(let user):
                    guard let schedule = user.schedule else {
                        completion(.failure(.unknownError))
                        return
                    }
                    
                    let dayPrograms = CalendarService.shared.getScheduleElement(from: schedule, at: date)
                    let programIDs = dayPrograms.map { $0.programID }
                    let group = DispatchGroup()
                    var workouts: [Workout] = Array(repeating: Workout(), count: programIDs.count)

                    for indexOfProgram in 0..<programIDs.count {
                        group.enter()
                        programIDs[indexOfProgram].getDocument(as: DayServiceProgram.self) { result in
                            defer {
                                group.leave()
                            }

                            switch result {
                            case .success(let workout):
                                let indexOfDay = dayPrograms[indexOfProgram].indexOfCurrentDay
                                let sets: [TrainingSet] = workout.days[indexOfDay].sets.map { .init(dtoModel: $0) }
                                workouts[indexOfProgram] = .init(
                                    workoutName: workout.name,
                                    dayName: workout.days[indexOfDay].name,
                                    dayIndex: indexOfDay,
                                    sets: sets
                                )
                                
                            case .failure:
                                completion(.failure(.unknownError))
                            }
                        }
                    }

                    group.notify(queue: .main) {
                        completion(.success(workouts))
                    }

                case .failure:
                    completion(.failure(.unknownError))
                }
            }
    }
    
    func getDayResults(on date: Date, completion: @escaping (Result<[Workout], CustomError>) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(.failure(.unknownError))
            return
        }

        db.collection(Constants.userCollection)
            .document(userUID)
            .getDocument(as: DayServiceUser.self) { result in
                switch result {
                case .success(let user):
                    guard let history = user.history else {
                        completion(.failure(.unknownError))
                        return
                    }
                    let workoutHistories = history.filter { $0.date.onlyDate == date.onlyDate }
                    guard !workoutHistories.isEmpty else {
                        completion(.failure(.unknownError))
                        return
                    }
                    let historyIDs: [DocumentReference] = workoutHistories.map { $0.historyID }

                    let group = DispatchGroup()
                    var workouts: [Workout] = Array(repeating: Workout(), count: historyIDs.count)

                    for indexOfProgram in 0..<historyIDs.count {
                        group.enter()
                        historyIDs[indexOfProgram].getDocument(as: DayServiceHistory.self) { result in
                            defer {
                                group.leave()
                            }

                            switch result {
                            case .success(let history):
                                workouts[indexOfProgram] = .init(dtoHistoryWorkout: history.workout)
                                
                            case .failure:
                                completion(.failure(.unknownError))
                                return
                            }
                        }
                    }

                    group.notify(queue: .main) {
                        completion(.success(workouts))
                        return
                    }

                case .failure:
                    completion(.failure(.unknownError))
                    return
                }
            }
    }
    
    // MARK: - POST
    
    func postProgress(_ progress: WorkoutProgress, completion: @escaping (CustomError?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(.unknownError)
            return
        }

        let historyCollectionReference = db.collection(Constants.historyCollection)
        let historyDocumentReference: DocumentReference?
        let history: DayServiceHistory = .init(domainModel: progress)
        do {
            historyDocumentReference = try historyCollectionReference.addDocument(from: history)
        } catch {
            completion(.unknownError)
            return
        }
        guard let historyDocumentReference else {
            completion(.unknownError)
            return
        }
        
        let historyElement: DayServiceHistoryElement = .init(
            date: Date(),
            historyID: historyDocumentReference
        )
        db.collection(Constants.userCollection).document(userUID)
            .updateData([
                Constants.User.historyField: FieldValue.arrayUnion([historyElement])
            ])
        
        completion(nil)
    }
}

// MARK: - Constants

private extension DayService {
    struct Constants {
        static let userCollection = "user"
        static let historyCollection = "history"
        
        struct User {
            static let historyField = "history"
        }
    }
}
