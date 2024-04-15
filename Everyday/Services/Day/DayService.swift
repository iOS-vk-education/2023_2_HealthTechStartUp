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
    func postProgress(_ progress: WorkoutProgress, completion: @escaping (Result<Bool, CustomError>) -> Void)
}

final class DayService: DayServiceDescription {
    static let shared: DayServiceDescription = DayService()
    private let db = Firestore.firestore()

    private init() {}
    
    // MARK: - GET
    
    func getDaySchedule(on date: Date, completion: @escaping (Result<[WorkoutDay], CustomError>) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(.failure(.unknownError))
            return
        }

        db.collection(Constants.userCollection)
            .document(userUID)
            .getDocument(as: NotepadUser.self) { result in
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
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(.failure(.unknownError))
            return
        }

        db.collection(Constants.userCollection)
            .document(userUID)
            .getDocument(as: NotepadUser.self) { result in
                switch result {
                case .success(let user):
                    guard let history = user.history else {
                        completion(.failure(.unknownError))
                        return
                    }
                    guard let dayHistory = history.filter({ $0.date.onlyDate == date.onlyDate }).first else {
                        completion(.failure(.unknownError))
                        return
                    }
                    let historyIDs: [DocumentReference] = dayHistory.historyID.map { $0.programID }

                    let group = DispatchGroup()
                    var workoutDays: [WorkoutDay] = Array(repeating: WorkoutDay(), count: historyIDs.count)

                    for indexOfProgram in 0..<historyIDs.count {
                        group.enter()
                        historyIDs[indexOfProgram].getDocument(as: Workout.self) { result in
                            defer {
                                group.leave()
                            }

                            switch result {
                            case .success(let workout):
                                let indexOfDay = dayHistory.historyID[indexOfProgram].indexOfDay
                                workoutDays[indexOfProgram] = .init(workout: workout, indexOfDay: indexOfDay)
                                
                            case .failure:
                                completion(.failure(.unknownError))
                                return
                            }
                        }
                    }

                    group.notify(queue: .main) {
                        completion(.success(workoutDays))
                        return
                    }

                case .failure:
                    completion(.failure(.unknownError))
                    return
                }
            }
    }
    
    // MARK: - POST
    
    func postProgress(_ progress: WorkoutProgress, completion: @escaping (Result<Bool, CustomError>) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(.failure(.unknownError))
            return
        }

        let historyCollectionReference = db.collection(Constants.historyCollection)
        let historyDocumentReference: DocumentReference?
        do {
            historyDocumentReference = try historyCollectionReference.addDocument(from: progress)
        } catch {
            completion(.failure(.unknownError))
            return
        }
        guard let historyDocumentReference else {
            completion(.failure(.unknownError))
            return
        }
        
        let historyElement: HistoryElement = .init(
            date: Date(),
            historyID: historyDocumentReference
        )
        db.collection(Constants.userCollection).document(userUID)
            .updateData([
                Constants.User.historyField: FieldValue.arrayUnion([historyElement])
            ])
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
