//
//  DayService.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//

import Foundation
import Firebase
import FirebaseStorage

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

        db.collection(Constants.Database.userCollection)
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

        db.collection(Constants.Database.userCollection)
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
    
    // MARK: - POST&PUT
    
    func postProgress(_ progress: WorkoutProgress, completion: @escaping (CustomError?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            completion(.unknownError)
            return
        }
        
        guard let data = progress.extra?.image?.jpegData(compressionQuality: 1.0) else {
            completion(.unknownError)
            return
        }
        var picUrl: URL?
        putPhoto(data: data) { [weak self] result in
            switch result {
            case .success(let url):
                picUrl = url
                
                guard let picUrlString = picUrl?.absoluteString else {
                    completion(.unknownError)
                    return
                }

                let historyCollectionReference = self?.db.collection(Constants.Database.historyCollection)
                
                guard let historyCollectionReference = historyCollectionReference else {
                    completion(.unknownError)
                    return
                }
                
                let historyDocumentReference: DocumentReference?

                let history: DayServiceHistory = .init(
                    workout: .init(domainModel: progress.workout),
                    extra: .init(
                        imageURL: picUrlString,
                        condition: progress.extra?.condition,
                        weight: progress.extra?.weight
                    )
                )

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
                self?.db.collection(Constants.Database.userCollection).document(userUID)
                    .updateData([
                        Constants.Database.User.historyField: FieldValue.arrayUnion([historyElement.dictionaryRepresentation])
                    ])
                
                completion(nil)
                
            case .failure:
                completion(.unknownError)
            }
        }
    }
    
    // MARK: - POST
    
    func putPhoto(data: Data, completion: @escaping (Result<URL, Error>) -> Void) {
        let fileName = UUID().uuidString
        let reference = Storage.storage().reference()
            .child(Constants.Storage.progressPictureCollection)
            .child(fileName)
        
        reference.putData(data) { result in
            switch result {
            case .success:
                reference.downloadURL(completion: completion)
            case .failure(let error):
                print("error in put photo")
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Constants

private extension DayService {
    struct Constants {
        struct Database {
            static let userCollection = "user"
            static let historyCollection = "history"
            
            struct User {
                static let historyField = "history"
            }
        }
        struct Storage {
            static let progressPictureCollection = "userPics"
        }
    }
}
