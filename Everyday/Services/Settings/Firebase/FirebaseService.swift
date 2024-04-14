//
//  FirebaseService.swift
//  Everyday
//
//  Created by Yaz on 29.03.2024.
//

import Foundation
import Firebase
import FirebaseAuth

protocol FirebaseServiceDescription {
    func updateEmail(with: ChangeEmailModel, completion: @escaping (Bool, Error?) -> Void)
    func updatePassword(with: ChangePasswordModel, completion: @escaping (Bool, Error?) -> Void)
    func fetchUserName(completion: @escaping (Bool, Error?, String?) -> Void)
    func fetchUserProfileImage(completion: @escaping (Bool, Error?, UIImage?) -> Void)
    func deleteOldImage(userId: String, completion: @escaping (Bool, Error?) -> Void)
    func updateProfileImagePath(path: String, completion: @escaping (Bool, Error?) -> Void)
    func deleteEmailAccount(email: String, password: String, completion: @escaping (Bool, Error?) -> Void)
    func deleteAnonymAccount(completion: @escaping (Bool, Error?) -> Void)
    func deleteGoogleAccount(completion: @escaping (Bool, Error?) -> Void)
    func deleteVkAccount(completion: @escaping (Bool, Error?) -> Void)
    func updateUserImage(image: UIImage, completion: @escaping (Bool, Error?) -> Void)
    func updateNickname(username: String, completion: @escaping (Bool, Error?) -> Void)
    func currentUser(completion: @escaping (User?, Error?) -> Void)
    func changeFieldInFireBase(field: String, value: String, completion: @escaping (Bool, Error?) -> Void)
    func deleteUserInFirebase(user: User, userId: String, completion: @escaping(Bool, Error?) -> Void)
    func signOut(completion: @escaping (Bool, Error?) -> Void)
    func resetPassword(email: String, completion: @escaping(Bool, Error?) -> Void)
}

final class FirebaseService {
    public static let shared = FirebaseService()
    private let db = Firestore.firestore()
    
    private init() {}
}

extension FirebaseService: FirebaseServiceDescription {
    
    func currentUser(completion: @escaping (User?, Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(nil, NSError(domain: "FirebaseService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пользователь не найден"]))
            return
        }
        completion(currentUser, nil)
    }
    
    func changeFieldInFireBase(field: String, value: String, completion: @escaping (Bool, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let reference = db.collection(Constants.user).document(userUID)
        
        reference.updateData([
            field: value
        ]) { error in
            guard error == nil else {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch let error {
            completion(false, error)
        }
    }
    
    func deleteUserInFirebase(user: User, userId: String, completion: @escaping (Bool, Error?) -> Void) {
        user.delete { error in
            guard error == nil else {
                completion(false, error)
                return
            }
        }
        
        self.deleteOldImage(userId: userId) { _, error in
            guard error == nil else {
                completion(false, error)
                return
            }
            self.db.collection(Constants.user).document(userId).delete { error in
                guard error == nil else {
                    completion(false, error)
                    return
                }
                completion(true, nil)
            }
        }
    }
    
    func updateEmail(with model: ChangeEmailModel, completion: @escaping (Bool, Error?) -> Void) {
        self.currentUser { user, error in
            guard let currentUser = user else {
                completion(false, error)
                return
            }
            
            let credential = EmailAuthProvider.credential(withEmail: currentUser.email!, password: model.password)
            
            currentUser.reauthenticate(with: credential) { _, error in
                guard error == nil else {
                    completion(false, error)
                    return
                }
                
                currentUser.sendEmailVerification(beforeUpdatingEmail: model.newEmail) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    guard (Auth.auth().currentUser?.uid) != nil else {
                        completion(false, NSError(domain: "FirebaseService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пользователь не найден"]))
                        return()
                    }
                    
                    self.changeFieldInFireBase(field: Constants.email, value: model.newEmail) { _, error in
                        guard error == nil else {
                            completion(false, error)
                            return
                        }
                        completion(true, nil)
                    }
                }
                
                currentUser.reload {error in
                    guard error == nil else {
                        completion(false, error)
                        return
                    }
                }
            }
        }
    }
    
    func updatePassword(with model: ChangePasswordModel, completion: @escaping (Bool, Error?) -> Void) {
        self.currentUser { user, error in
            guard let currentUser = user else {
                completion(false, error)
                return
            }
            
            let credential = EmailAuthProvider.credential(withEmail: currentUser.email!, password: model.oldPassword)
            
            currentUser.reauthenticate(with: credential) { _, error in
                guard error == nil else {
                    completion(false, error)
                    return
                }
                
                currentUser.updatePassword(to: model.newPassword) { error in
                    guard error == nil else {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
            }
        }
    }
    
    func deleteAnonymAccount(completion: @escaping (Bool, Error?) -> Void) {
        if let currentUser = Auth.auth().currentUser {
            let userId = currentUser.uid
            if currentUser.isAnonymous {
                deleteUserInFirebase(user: currentUser, userId: userId) { _, error in
                    guard error == nil else {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
            } else {
                completion(false, NSError(domain: "FirebaseService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пользователь не анонимный"]))
            }
        } else {
            completion(false, NSError(domain: "FirebaseService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пользователь не найден"]))
        }
    }
    
    func deleteVkAccount(completion: @escaping (Bool, Error?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(false, NSError(domain: "FirebaseService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пользователь не найден"]))
            return
        }
        
        let userId = currentUser.uid
        
        deleteUserInFirebase(user: currentUser, userId: userId) { _, error in
            guard error == nil else {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    func deleteGoogleAccount(completion: @escaping (Bool, Error?) -> Void) {
        self.currentUser { user, error in
            guard let currentUser = user else {
                completion(false, error)
                return
            }
            let userId = currentUser.uid
            
            if currentUser.providerData.contains(where: { $0.providerID == "google.com" }) {
                self.deleteUserInFirebase(user: currentUser, userId: userId) { _, error in
                    guard error == nil else {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
            }
        }
            completion(false, NSError(domain: "FirebaseService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Пользователь не найден"]))
    }
    
    func deleteEmailAccount(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        self.currentUser { user, error in
            guard let currentUser = user else {
                completion(false, error)
                return
            }
            let userId = currentUser.uid
            
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            
            currentUser.reauthenticate(with: credential) { _, error in
                guard error == nil else {
                    completion(false, error)
                    return
                }
                
                self.deleteUserInFirebase(user: currentUser, userId: userId) { _, error in
                    guard error == nil else {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
            }
        }
    }
    
    func fetchUserName(completion: @escaping (Bool, Error?, String?) -> Void) {
        self.currentUser { user, error in
            guard let currentUser = user else {
                completion(false, error, nil)
                return
            }
            
            let userUID = currentUser.uid
            
            let db = Firestore.firestore()
            db.collection(Constants.user)
                .document(userUID)
                .getDocument { snapshot, error in
                    guard error == nil else {
                        completion(false, error, nil)
                        return
                    }
                    
                    if let snapshot = snapshot,
                       let snapshotData = snapshot.data(),
                       let userName = snapshotData[Constants.nickname] as? String {
                        completion(true, nil, userName)
                    }
                }
        }
    }
    
    func fetchUserProfileImage(completion: @escaping (Bool, Error?, UIImage?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, NSError(domain: "FirebaseAuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "UID пользователя не найден"]), nil)
            return
        }
        
        let db = Firestore.firestore()
        db.collection(Constants.user)
            .document(userId)
            .getDocument { snapshot, error in
                guard error == nil else {
                    completion(false, error, nil)
                    return
                }
                
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let profileImagePath = snapshotData[Constants.profileImage] as? String {
                    let storage: StorageServiceDescription = StorageService.shared
                    Task {
                        do {
                            try await storage.getImage(path: profileImagePath) { image, error in
                                guard error == nil else {
                                    completion(false, error, nil)
                                    return
                                }
                                completion(true, nil, image)
                            }
                        } catch {
                            completion(false, error, nil)
                        }
                    }
                }
            }
    }
    
    func deleteOldImage(userId: String, completion: @escaping (Bool, Error?) -> Void) {
        var isImageDeleted = false
        let lock = NSLock()
        
        let db = Firestore.firestore()
        db.collection(Constants.user)
            .document(userId)
            .getDocument { snapshot, error in
                guard error == nil else {
                    completion(false, error)
                    return
                }
                
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let profileOldImagePath = snapshotData[Constants.profileImage] as? String {
                    lock.lock()
                    defer {
                        lock.unlock()
                    }
                    
                    guard !isImageDeleted else {
                        completion(true, nil)
                        return
                    }
                    
                    let storage: StorageServiceDescription = StorageService.shared
                    Task {
                        do {
                            try await storage.deleteOldImage(userId: userId, path: profileOldImagePath)
                            isImageDeleted = true
                            completion(true, nil)
                        } catch {
                            completion(false, error)
                        }
                    }
                }
            }
    }
    
    func updateProfileImagePath(path: String, completion: @escaping (Bool, Error?) -> Void) {
        changeFieldInFireBase(field: Constants.profileImage, value: path) { _, error in
            guard error == nil else {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    func updateUserImage(image: UIImage, completion: @escaping (Bool, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, NSError(domain: "FirebaseAuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "UID пользователя не найден"]))
            return
        }
        
        Task {
            do {
                deleteOldImage(userId: userId) { _, error in
                    guard error == nil else {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
            }
        }
        
        let storage: StorageServiceDescription = StorageService.shared
        Task {
            do {
                let (path, _) = try await storage.saveImage(image: image, userId: userId)
                updateProfileImagePath(path: path) { _, error in
                    guard error == nil else {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
            } catch {
                completion(false, error)
            }
        }
    }
    
    func updateNickname(username: String, completion: @escaping (Bool, Error?) -> Void) {
        changeFieldInFireBase(field: Constants.nickname, value: username) { _, error in
            guard error == nil else {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                completion(false, error)
                return
            }
            completion(true, nil)
        }
    }
}

private extension FirebaseService {
    struct Constants {
        static let user = "user"
        static let nickname = "nickname"
        static let profileImage = "profileImage"
        static let email = "email"
    }
}
