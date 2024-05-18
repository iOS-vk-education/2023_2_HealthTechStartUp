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
        Fetcher.shared.fetchWorkouts(from: references, completion: completion)
    }
}
