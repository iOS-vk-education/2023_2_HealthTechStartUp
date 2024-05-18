//
//  TrainingTypeService.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//

import Foundation
import UIKit
import Firebase

enum Training {
    case fullBody
    case legs
    case hands
    case chest
    case shoulders
    case press
    case back
}

extension Training {
    var description: String {
        switch self {
        case .fullBody:
            return "FullBody"
        case .legs:
            return "Legs"
        case .hands:
            return "Hands"
        case .chest:
            return "Chest"
        case .shoulders:
            return "Shoulders"
        case .press:
            return "Press"
        case .back:
            return "Back"
        }
    }
}

protocol TrainingTypeServiceDescription {
    func loadWorkouts(for training: Training, completion: @escaping ([Train]?, Error?) -> Void)
}

class TrainingTypeService: TrainingTypeServiceDescription {
    static let shared = TrainingTypeService()
    private let db = Firestore.firestore()

    func loadWorkouts(for training: Training, completion: @escaping ([Train]?, Error?) -> Void) {
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
            self.parseDocument(document, for: training, completion: completion)
        }
    }

    func parseDocument(_ document: DocumentSnapshot, for training: Training, completion: @escaping ([Train]?, Error?) -> Void) {
        guard let type = document.data()?["type"] as? [String: Any],
              let trainingMap = type["training"] as? [String: Any],
              let references = trainingMap[training.description] as? [DocumentReference], !references.isEmpty  else {
            completion(nil, NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found in workout document."]))
            return
        }
        Fetcher.shared.fetchWorkouts(from: references, completion: completion)
    }
}
