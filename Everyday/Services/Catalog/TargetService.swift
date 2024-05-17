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

        db.collection("catalog").document(documentId).getDocument { (document, error) in
            guard let document = document, document.exists, error == nil else {
                completion(nil, error)
                return
            }

            if let type = document.data()?["type"] as? [String: Any],
               let targetMap = type["target"] as? [String: Any],
               let references = targetMap[target.description] as? [DocumentReference] {
                var workouts = [Train]()
                let group = DispatchGroup()

                references.forEach { ref in
                    group.enter()
                    ref.getDocument { (workoutDoc, error) in
                        guard let workoutDict = workoutDoc?.data(), error == nil, let workout = Train(dictionary: workoutDict) else {
                            group.leave()
                            return
                        }
                        workouts.append(workout)
                        group.leave()
                    }
                }

                group.notify(queue: .main) {
                    completion(workouts, nil)
                }
            } else {
                completion(nil, error)
            }
        }
    }
}
