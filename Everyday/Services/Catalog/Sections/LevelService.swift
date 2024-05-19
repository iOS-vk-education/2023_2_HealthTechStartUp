//
//  LevelService.swift
//  Everyday
//
//  Created by Михаил on 18.05.2024.
//

import UIKit
import Firebase

enum Level {
    case easy
    case medium
    case pro
}

extension Level {
    var description: String {
        switch self {
        case .easy:
            return "easy"
        case .medium:
            return "medium"
        case .pro:
            return "pro"
        }
    }
}

protocol LevelServiceDescription {
    func loadWorkouts(for level: Level, completion: @escaping ([Train]?, Error?) -> Void)
}

class LevelService: LevelServiceDescription {
    static let shared = LevelService()
    private let db = Firestore.firestore()
    
    func loadWorkouts(for level: Level, completion: @escaping ([Train]?, Error?) -> Void) {
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
            self.parseDocument(document, for: level, completion: completion)
        }
    }
    
    private func parseDocument(_ document: DocumentSnapshot, for level: Level, completion: @escaping ([Train]?, Error?) -> Void) {
        var references = [DocumentReference]()
        let group = DispatchGroup()
        
        guard let type = document.data()?["type"] as? [String: Any] else {
            return
        }
        
        for (_, subMap) in type {
            if let subDict = subMap as? [String: Any] {
                for (_, arrayRefs) in subDict {
                    if let refs = arrayRefs as? [DocumentReference] {
                        for ref in refs {
                            group.enter()
                            ref.getDocument { docSnapshot, _ in
                                defer { group.leave() }
                                guard let docSnapshot = docSnapshot, let workoutDict = docSnapshot.data(),
                                      let workoutLevel = workoutDict["level"] as? String, workoutLevel == level.description else {
                                    return
                                }
                                references.append(ref)
                            }
                        }
                    }
                }
            }
        }
                
        group.notify(queue: .main) {
            if references.isEmpty {
                completion(nil, NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found for the specified level."]))
            } else {
                Fetcher.shared.fetchWorkouts(from: references, completion: completion)
            }
        }
    }
}
