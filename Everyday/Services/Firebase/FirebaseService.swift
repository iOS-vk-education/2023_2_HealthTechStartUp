//
//  FirebaseService.swift
//  Everyday
//
//  Created by Yaz on 29.03.2024.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

protocol FirebaseServiceDescription {
    func updateEmail(with: ChangeEmailModel, completion: @escaping (Bool, Error?) -> Void)
    func updatePassword(with: ChangePasswordModel, completion: @escaping (Bool, Error?) -> Void)
    func deleteAccount(with: DeleteAccountModel, completion: @escaping (Bool, Error?) -> Void)
    func fetchUserName(completion: @escaping (Bool, Error?, String?) -> Void)
    func fetchUserProfileImage(completion: @escaping (Bool, Error?, UIImage?) -> Void)
    func updateNickname(username: String, completion: @escaping (Bool, Error?) -> Void)
}

final class FirebaseService: FirebaseServiceDescription {
    public static let shared = FirebaseService()
    
    private init() {}
    
    func updateNickname(username: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()

        let reference = db.collection("user").document(userUID)

        reference.updateData([
            "nickname": username
        ])
    }

    func fetchUserName(completion: @escaping (Bool, Error?, String?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let userUID = currentUser.uid
        
        let db = Firestore.firestore()
        db.collection("user")
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(false, error, nil)
                    return
                }
                
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let userName = snapshotData["nickname"] as? String {
                    completion(true, nil, userName)
                }
            }
    }
    
    func deleteAccount(with model: DeleteAccountModel, completion: @escaping (Bool, Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let userUID = currentUser.uid
        let credential = EmailAuthProvider.credential(withEmail: model.email, password: model.password)
        
        currentUser.reauthenticate(with: credential) { _, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            currentUser.delete { error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                let db = Firestore.firestore()
                db.collection("user").document(userUID).delete { error in
                    if let error = error {
                        completion(false, error)
                        return
                    } else {
                        completion(true, nil)
                    }
                }
            }
        }
    }
    func updateEmail(with model: ChangeEmailModel, completion: @escaping (Bool, Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: currentUser.email!, password: model.password)
        
        currentUser.reauthenticate(with: credential) { _, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            currentUser.sendEmailVerification(beforeUpdatingEmail: model.newEmail) { error in
                if let error = error {
                    completion(false, error)
                    return
                }
                guard let userUID = Auth.auth().currentUser?.uid else {
                    return
                }
                
                let db = Firestore.firestore()

                let reference = db.collection("user").document(userUID)

                reference.updateData([
                    "email": model.newEmail
                ])
            }
            
            currentUser.reload {error in
                if let error = error {
                    completion(false, error)
                    return
                }
            }
        }
    }
    
    func updatePassword(with model: ChangePasswordModel, completion: @escaping (Bool, Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: currentUser.email!, password: model.oldPassword)
        
        currentUser.reauthenticate(with: credential) { _, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            currentUser.updatePassword(to: model.newPassword) { error in
                if let error = error {
                    completion(false, error)
                    return
                }
            }
        }
    }
    
    func fetchUserProfileImage(completion: @escaping (Bool, Error?, UIImage?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, NSError(domain: "FirebaseAuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "UID пользователя не найден"]), nil)
            return
        }
        
        let storage: StorageServiceDescription = StorageService.shared
        Task {
            do {
                try await storage.getImage(userId: userId) { image, error in
                    if let error = error {
                        completion(false, error, nil)
                    } else {
                        completion(true, nil, image)
                    }
//                    completion(true, nil, image)
                }
            }
        }
    }
}
