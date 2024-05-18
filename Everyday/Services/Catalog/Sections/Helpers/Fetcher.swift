//
//  Fetcher.swift
//  Everyday
//
//  Created by Михаил on 18.05.2024.
//

import Firebase

final class Fetcher {
    static let shared = Fetcher()
    
    func isDownloaded(recordId: String, forUser userId: String, completion: @escaping (Bool) -> Void) {
            let userRef = Firestore.firestore().collection("user").document(userId)
            userRef.getDocument { document, _ in
                if let document = document, document.exists {
                    let data = document.data()
                    if let downloaded = data?["downloaded"] as? [String] {
                        completion(downloaded.contains(recordId))
                    } else {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            }
        }
        
        func updateDownloadStatus(with recordId: String, forUser userId: String, isDownloaded: Bool) {
            let userRef = Firestore.firestore().collection("user").document(userId)
            userRef.getDocument { document, _ in
                if let document = document, document.exists {
                    let data = document.data()
                    var downloaded = data?["downloaded"] as? [String] ?? []
                    if isDownloaded {
                        if !downloaded.contains(recordId) {
                            downloaded.append(recordId)
                        }
                    } else {
                        downloaded.removeAll { $0 == recordId }
                    }
                    userRef.updateData(["downloaded": downloaded])
                } else {
                    userRef.setData(["downloaded": isDownloaded ? [recordId] : []], merge: true)
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
