//
//  Fetcher.swift
//  Everyday
//
//  Created by Михаил on 18.05.2024.
//

import Firebase

final class Fetcher {
    static let shared = Fetcher()
    
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

                self.loadProgramNames(from: workoutDict) { exerciseNames, error in
                    if let error = error {
                        completion(nil, error)
                    } else if var workout = Train(dictionary: workoutDict) {
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
