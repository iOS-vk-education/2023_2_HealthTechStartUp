//
//  OtherService.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//

import Foundation
import UIKit
import Firebase

enum Other {
    case charge
    case kegel
    case eye
}

extension Other {
    var description: String {
        switch self {
        case .charge:
            return "charge"
        case .kegel:
            return "kegel"
        case .eye:
            return "eye"
        }
    }
}

protocol OtherServiceDescription {
    func loadWorkouts(for other: Other, completion: @escaping ([Train]?, Error?) -> Void)
}

class OtherService: OtherServiceDescription {
    static let shared = OtherService()
    private let db = Firestore.firestore()

    func loadWorkouts(for other: Other, completion: @escaping ([Train]?, Error?) -> Void) {
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
            self.parseDocument(document, for: other, completion: completion)
        }
    }

    func parseDocument(_ document: DocumentSnapshot, for other: Other, completion: @escaping ([Train]?, Error?) -> Void) {
        guard let type = document.data()?["type"] as? [String: Any],
              let otherMap = type["other"] as? [String: Any],
              let references = otherMap[other.description] as? [DocumentReference], !references.isEmpty  else {
            completion(nil, NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found in workout document."]))
            return
        }
        Fetcher.shared.fetchWorkouts(from: references, completion: completion)
    }
}
