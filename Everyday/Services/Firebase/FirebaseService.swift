//
//  FirebaseService.swift
//  Everyday
//
//  Created by Yaz on 29.03.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase

protocol FirebaseServiceDescription {
    func updateEmail(with: ChangeEmailModel, completion: @escaping (Bool, Error?) -> Void)
    func updatePassword(with: ChangePasswordModel, completion: @escaping (Bool, Error?) -> Void)
    func deleteAccount(with: DeleteAccountModel, completion: @escaping (Bool, Error?) -> Void)
    func fetchUserName(completion: @escaping (Bool, Error?, String?) -> Void)
    func fetchUserProfileImage(completion: @escaping (Bool, Error?, UIImage?) -> Void)
    func deleteOldImage(completion: @escaping (Bool, Error?) -> Void)
//    func fetchProfileImagePath(completion: @escaping(Bool, Error?, String?) -> Void)
    func updateProfileImagePath(path: String, completion: @escaping (Bool, Error?) -> Void)
    func updateUserImage(image: UIImage, completion: @escaping (Bool, Error?) -> Void)
    func updateNickname(username: String, completion: @escaping (Bool, Error?) -> Void)
}

final class FirebaseService: FirebaseServiceDescription {
    public static let shared = FirebaseService()
    
    private init() {}
    
    func updateEmail(with model: ChangeEmailModel, completion: @escaping (Bool, Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(false, NSError(domain: "FirebaseService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пользователь не найден"]))
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
            completion(false, NSError(domain: "FirebaseService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пользователь не найден"]))
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
    
    func fetchUserName(completion: @escaping (Bool, Error?, String?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(false, NSError(domain: "FirebaseService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пользователь не найден"]), nil)
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
    
    func fetchUserProfileImage(completion: @escaping (Bool, Error?, UIImage?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, NSError(domain: "FirebaseAuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "UID пользователя не найден"]), nil)
            return
        }
        
        let db = Firestore.firestore()
        db.collection("user")
            .document(userId)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(false, error, nil)
                    return
                }
                
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let profileImagePath = snapshotData["profileImage"] as? String {
                    let storage: StorageServiceDescription = StorageService.shared
                    Task {
                        do {
                            try await storage.getImage(path: profileImagePath) { image, error in
                                if let error = error {
                                    completion(false, error, nil)
                                } else {
                                    completion(true, nil, image)
                                }
                            }
                        } catch {
                            completion(false, error, nil)
                        }
                    }
                }
            }
    }
    
    func deleteOldImage(completion: @escaping (Bool, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, NSError(domain: "FirebaseAuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "UID пользователя не найден"]))
            return
        }
        
        let db = Firestore.firestore()
        db.collection("user")
            .document(userId)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let profileOldImagePath = snapshotData["profileImage"] as? String {
                    let storage: StorageServiceDescription = StorageService.shared
                    Task {
                        do {
                            try await storage.deleteOldImage(userId: userId, path: profileOldImagePath)
                        } catch {
                            completion(false, error)
                        }
                    }
                }
            }
    }
    
    func updateProfileImagePath(path: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()

        let reference = db.collection("user").document(userUID)

        reference.updateData([
            "profileImage": path
        ]) { error in
            if let error = error {
                completion(false, error)
            }
        }
    }
    
    func updateUserImage(image: UIImage, completion: @escaping (Bool, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, NSError(domain: "FirebaseAuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "UID пользователя не найден"]))
            return
        }
        
        Task {
            do {
                deleteOldImage { _, error in
                    if let error = error {
                        completion(false, error)
                    }
                }
            }
        }
        
            let storage: StorageServiceDescription = StorageService.shared
        Task {
            do {
                let (path, _) = try await storage.saveImage(image: image, userId: userId)
                updateProfileImagePath(path: path) { _, error in
                    if let error = error {
                        completion(false, error)
                        return
                    } else {
                        completion(true, nil)
                    }
                }
            } catch {
                completion(false, error)
            }
        }
    }
    
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
}
