//
//  TrainingService.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//

import Foundation
import UIKit
import Firebase

enum Target {
    case recovery
    case stamina
    case flexibility
    case muscleRelief
    case coordination
    case weightLoss
    case muscleGain
    case posture
}

extension Target {
    var description: String {
        switch self {
        case .recovery:
            return "recovery"
        case .stamina:
            return "stamina"
        case .flexibility:
            return "flexibility"
        case .muscleRelief:
            return "muscleRelief"
        case .coordination:
            return "coordination"
        case .weightLoss:
            return "weightLoss"
        case .muscleGain:
            return "muscleGain"
        case .posture:
            return "posture"
        }
    }
}

protocol TargetServiceDescription {
    func loadWorkouts(for target: Target, completion: @escaping ([Train]?, Error?) -> Void)
}

class TargetService: TargetServiceDescription {
    static let shared = TargetService()
    private let db = Firestore.firestore()

    func loadWorkouts(for target: Target, completion: @escaping ([Train]?, Error?) -> Void) {
        let documentId = "jY2UXkwatRwnoPGiyTWP"
        db.collection("catalog").document(documentId).getDocument { document, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let document = document, document.exists else {
                completion(nil, NSError(domain: "FirebaseError", code: 404, userInfo: [NSLocalizedDescriptionKey: "No document found."]))
                return
            }
            self.parseDocument(document, for: target, completion: completion)
        }
    }

    private func parseDocument(_ document: DocumentSnapshot, for target: Target, completion: @escaping ([Train]?, Error?) -> Void) {
        guard let type = document.data()?["type"] as? [String: Any],
              let targetMap = type["target"] as? [String: Any],
              let references = targetMap[target.description] as? [DocumentReference], !references.isEmpty  else {
            completion(nil, NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found in workout document."]))
            return
        }
        fetchWorkouts(from: references, completion: completion)
    }

    private func fetchWorkouts(from references: [DocumentReference], completion: @escaping ([Train]?, Error?) -> Void) {
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
