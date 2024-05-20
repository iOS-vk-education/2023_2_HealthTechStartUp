//
//  Fetcher.swift
//  Everyday
//
//  Created by Михаил on 18.05.2024.
//

import Firebase

final class Fetcher {
    static let shared = Fetcher()
    
    func deleteSchedule(for recordId: String, forUser userId: String, completion: @escaping (Bool) -> Void) {
        let userRef = Firestore.firestore().collection("user").document(userId)
        let workoutRef = Firestore.firestore().collection("workout").document(recordId)

        workoutRef.getDocument { workoutDocument, error in
            guard let workoutDocument = workoutDocument, workoutDocument.exists, let workoutData = workoutDocument.data(),
                  let programReferences = workoutData["programs"] as? [DocumentReference] else {
                completion(false)
                return
            }

            userRef.getDocument { userDocument, error in
                guard let userDocument = userDocument, userDocument.exists, var userData = userDocument.data() else {
                    completion(false)
                    return
                }

                var schedule = userData["schedule"] as? [String: [[String: Any]]] ?? [:]
                for dayKey in schedule.keys {
                    schedule[dayKey] = schedule[dayKey]?.filter { entry in
                        guard let programID = entry["programID"] as? DocumentReference else {
                            return true
                        }
                        return !programReferences.contains(programID)
                    }
                }

                userData["schedule"] = schedule
                userRef.updateData(userData) { error in
                    completion(error == nil)
                }
            }
        }
    }
    
    func updateSchedule(with recordId: String, forUser userId: String, selectedDays: [String], completion: @escaping (Bool) -> Void) {
        let userRef = Firestore.firestore().collection("user").document(userId)
        let workoutRef = Firestore.firestore().collection("workout").document(recordId)

        workoutRef.getDocument { document, error in
            guard let document = document, document.exists, let workoutData = document.data(),
                  let programReferences = workoutData["programs"] as? [DocumentReference], !programReferences.isEmpty else {
                completion(false)
                return
            }

            var allProgramDays = [[String: Any]]()
            var programRefs = [DocumentReference]()
            let dispatchGroup = DispatchGroup()
            var errorOccurred = false

            for programRef in programReferences {
                dispatchGroup.enter()
                programRef.getDocument { programDocument, _ in
                    defer { dispatchGroup.leave() }
                    guard let programDocument = programDocument, programDocument.exists, let programData = programDocument.data(),
                          let programDays = programData["days"] as? [[String: Any]], !programDays.isEmpty else {
                        errorOccurred = true
                        return
                    }
                    allProgramDays.append(contentsOf: programDays)
                    programRefs.append(programRef)
                }
            }

            dispatchGroup.notify(queue: .main) {
                if errorOccurred {
                    completion(false)
                    return
                }

                userRef.getDocument { userDocument, error in
                    guard let userDocument = userDocument, userDocument.exists, var userData = userDocument.data() else {
                        completion(false)
                        return
                    }

                    var schedule = userData["schedule"] as? [String: [[String: Any]]] ?? [:]
                    for dayKey in schedule.keys {
                        schedule[dayKey] = schedule[dayKey]?.filter { entry in
                            guard let programID = entry["programID"] as? DocumentReference else {
                                return true
                            }
                            return !programReferences.contains(programID)
                        }
                    }

                    let dayKeys = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
                    var scheduleMap = [String: Int]()
                    for day in selectedDays {
                        guard let dayKey = dayKeys.first(where: { $0.hasPrefix(day.prefix(2)) }) else {
                            continue
                        }
                        scheduleMap[dayKey] = schedule[dayKey]?.count ?? 0
                    }

                    var currentIndex = 0
                    for (index, programDay) in allProgramDays.enumerated() {
                        let dayIndex = currentIndex % selectedDays.count
                        let day = selectedDays[dayIndex]
                        guard let dayKey = dayKeys.first(where: { $0.hasPrefix(day.prefix(2)) }) else {
                            continue
                        }
                        var daySchedule = schedule[dayKey] ?? []

                        let programRef = programRefs[index % programRefs.count]
                        let programEntry: [String: Any] = ["indexOfCurrentDay": currentIndex, "programID": programRef]
                        daySchedule.append(programEntry)
                        scheduleMap[dayKey]! += 1
                        currentIndex += 1

                        schedule[dayKey] = daySchedule
                    }

                    userData["schedule"] = schedule
                    userRef.updateData(userData) { error in
                        completion(error == nil)
                    }
                }
            }
        }
    }

    func isDownloaded(recordId: String, forUser userId: String, completion: @escaping (Bool) -> Void) {
        let userRef = Firestore.firestore().collection("user").document(userId)
        let workoutRef = Firestore.firestore().collection("workout").document(recordId)
        
        userRef.getDocument { document, _ in
            if let document = document, document.exists {
                let data = document.data()
                if let downloaded = data?["downloaded"] as? [DocumentReference] {
                    completion(downloaded.contains(where: { $0.path == workoutRef.path }))
                } else {
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
    
    func updateDownloadStatus(with recordId: String, forUser userId: String, isDownloaded: Bool) {
        let db = Firestore.firestore()
        let userRef = db.collection("user").document(userId)
        let workoutRef = db.collection("workout").document(recordId)

        let update: [String: Any]
        if isDownloaded {
            update = ["downloaded": FieldValue.arrayUnion([workoutRef])]
        } else {
            update = ["downloaded": FieldValue.arrayRemove([workoutRef])]
        }

        userRef.updateData(update) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func updateDownloadStatus(with recordId: String, forUser userId: String, isDownloaded: Bool, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("user").document(userId)
        let workoutRef = db.collection("workout").document(recordId)

        let update: [String: Any]
        if isDownloaded {
            update = ["downloaded": FieldValue.arrayUnion([workoutRef])]
        } else {
            update = ["downloaded": FieldValue.arrayRemove([workoutRef])]
        }

        userRef.updateData(update) { error in
            if let error = error {
                print("Error updating document: \(error)")
                completion(false)
            } else {
                print("Document successfully updated")
                completion(true)
            }
        }
    }

    func isFavorited(recordId: String, forUser userId: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("user").document(userId)
        
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                if let featured = data?["featured"] as? [String], featured.contains(recordId) {
                    completion(true)
                } else {
                    completion(false)
                }
            } else {
                print("Document does not exist or error: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
            }
        }
    }
    
    func updateFavoriteStatus(with record: String, forUser userId: String, isFavorited: Bool) {
        let db = Firestore.firestore()
        let userRef = db.collection("user").document(userId)
        
        let update: [String: Any]
        if isFavorited {
            update = ["featured": FieldValue.arrayUnion([record])]
        } else {
            update = ["featured": FieldValue.arrayRemove([record])]
        }
        
        userRef.updateData(update) { error in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func fetchWorkouts(from references: [DocumentReference], completion: @escaping ([Train]?, Error?) -> Void) {
        var workouts = [Train]()
        let group = DispatchGroup()

        for ref in references {
            group.enter()
            ref.getDocument { document, error in
                guard let document = document, let workoutDict = document.data() else {
                    group.leave()
                    completion(nil, NSError(domain: "FirebaseError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid workout data."]))
                    return
                }
                
                var workoutDataWithUid = workoutDict
                    workoutDataWithUid["id"] = document.documentID

                self.loadProgramNames(from: workoutDict) { exerciseNames, error in
                    if let error = error {
                        completion(nil, error)
                    } else if var workout = Train(dictionary: workoutDataWithUid) {
                        workout.exercises = exerciseNames
                        workouts.append(workout)
                    }
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            completion(workouts, nil)
        }
    }

    private func loadProgramNames(from workoutDict: [String: Any], completion: @escaping ([String], Error?) -> Void) {
        guard let programReferences = workoutDict["programs"] as? [DocumentReference] else {
            completion([], NSError(domain: "FirebaseError", code: 500, userInfo: [NSLocalizedDescriptionKey: "No program references found."]))
            return
        }

        var uniqueExerciseNames = Set<String>()
        let group = DispatchGroup()

        for ref in programReferences {
            group.enter()
            ref.getDocument { programDoc, error in
                defer { group.leave() }
                if let error = error {
                    completion([], error)
                    return
                }
                if let programDict = programDoc?.data(), let days = programDict["days"] as? [[String: Any]] {
                    for day in days {
                        if let sets = day["sets"] as? [[String: Any]] {
                            for set in sets {
                                if let exercises = set["exercises"] as? [[String: Any]] {
                                    for exercise in exercises {
                                        if let name = exercise["name"] as? String {
                                            uniqueExerciseNames.insert(name)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        group.notify(queue: .main) {
            completion(Array(uniqueExerciseNames), nil)
        }
    }
}

// MARK: - user programs

extension Fetcher {
    func fetchDownloadedWorkouts(forUser userId: String, completion: @escaping ([Train]?, Error?) -> Void) {
        let userRef = Firestore.firestore().collection("user").document(userId)
        
        userRef.getDocument { [weak self] document, error in
            guard let self = self else {
                return
            }
            if let error = error {
                completion(nil, error)
                return
            }
                        
            guard let document = document, document.exists,
                    let data = document.data(),
                    let references = data["downloaded"] as? [DocumentReference], !references.isEmpty else {
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found in workout document."]))
                return
            }
            
            self.fetchWorkouts(from: references, completion: completion)
        }
    }
}
