//
//  FIrebaseAuthService.swift
//  Everyday
//
//  Created by Михаил on 20.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase

final class AuthModel {
    static let shared = AuthModel()
    
    enum Sign {
        case vk
        case google
        case common
        case anonym
        case none
        case email
    }
    
    var whichSign: Sign = .none

    private init() {
    }
}

protocol FirebaseAuthServiceDescription {
    func registerUser(with userRequest: ProfileAcknowledgementModel, completion: @escaping(Bool, Error?) -> Void)
    func login(with userRequest: SignInModel, completion: @escaping(Bool, Error?) -> Void)
    func anonymLogin(completion: @escaping (Bool, Error?) -> Void)
    func signOut(completion: @escaping (Bool, Error?) -> Void)
    func updateEmail(with: ChangeEmailModel, completion: @escaping (Bool, Error?) -> Void)
    func updatePassword(with: ChangePasswordModel, completion: @escaping (Bool, Error?) -> Void)
    func deleteAccount(with: DeleteAccountModel, completion: @escaping (Bool, Error?) -> Void)
    func fetchUserName(completion: @escaping (Bool, Error?, String?) -> Void)
    func fetchUserProfileImage(completion: @escaping (Bool, Error?, UIImage?) -> Void)
    func updateNickname(username: String, completion: @escaping (Bool, Error?) -> Void)
    // func forgotPassword(with email: String, completion: @escaping (Error?) -> Void)
}

final class FirebaseAuthService: FirebaseAuthServiceDescription {
    public static let shared = FirebaseAuthService()
    
    private init() {}
    
    func registerUser(with userRequest: ProfileAcknowledgementModel, completion: @escaping(Bool, Error?) -> Void) {
        switch AuthModel.shared.whichSign {
        case .google, .vk, .common, .anonym:
            performAuth(userRequest: userRequest, completion: completion)
        default:
            completion(false, nil)
        }
    }
    
   func login(with userRequest: SignInModel, completion: @escaping (Bool, Error?) -> Void) {
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(false, error)
                return
            } else {
                completion(true, nil)
            }
        }
    }
    
    func anonymLogin(completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signInAnonymously { _, error in
            if let error = error {
                completion(false, error)
                return
            } else {
                completion(true, nil)
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
    
    func signOut(completion: @escaping (Bool, Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true, nil)
        } catch let error {
            completion(false, error)
        }
    }
    
    private func performAuth(userRequest: ProfileAcknowledgementModel, completion: @escaping(Bool, Error?) -> Void) {
        let email = userRequest.email ?? ""
        let password = userRequest.password ?? ""
        
        let authAction: ((AuthDataResult?, Error?) -> Void) = { result, error in
            self.handleAuthResult(result: result, error: error, userRequest: userRequest, completion: completion)
        }
        
        switch AuthModel.shared.whichSign {
        case .google:
            guard let credential = GoogleAuthService.shared.credential else {
                return completion(false, nil)
            }
            Auth.auth().signIn(with: credential, completion: authAction)
        case .vk, .common:
            Auth.auth().createUser(withEmail: email, password: password, completion: authAction)
        case .anonym:
            Auth.auth().signInAnonymously(completion: authAction)
        default:
            completion(false, nil)
        }
    }
    
    private func handleAuthResult(result: AuthDataResult?, 
                                  error: Error?,
                                  userRequest: ProfileAcknowledgementModel,
                                  completion: @escaping(Bool, Error?) -> Void) {
        if let error = error {
            completion(false, error)
            return
        }
        
        guard let resultUser = result?.user else {
            completion(false, nil)
            return
        }
        
       updateUserProfile(resultUser: resultUser, userRequest: userRequest, completion: completion)
    }
    
    private func updateUserProfile(resultUser: User, userRequest: ProfileAcknowledgementModel, completion: @escaping(Bool, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, NSError(domain: "FirebaseAuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "UID пользователя не найден"]))
            return
        }
        
        if let profileImage = userRequest.profileImage {
            let storage: StorageServiceDescription = StorageService.shared
            Task {
                do {
                    let (path, _) = try await storage.saveImage(image: profileImage, userId: userId)
                    let userData: [String: Any] = [
                        "firstname": userRequest.firstname ?? "",
                        "lastname": userRequest.lastname ?? "",
                        "nickname": userRequest.nickname ?? "",
                        "email": userRequest.email ?? "",
                        "age": userRequest.age ?? "",
                        "gender": userRequest.gender ?? "",
                        "weight": userRequest.weight ?? "",
                        "schedule": userRequest.schedule,
                        "profileImage": path,
                        "measureUnit": userRequest.measureUnit ?? ""
                    ]
                    
                    try await Firestore.firestore().collection("user").document(userId).setData(userData)
                    completion(true, nil)
                } catch {
                    completion(false, error)
                }
            }
        }
    }
    
    func fetchUserProfileImage(completion: @escaping (Bool, Error?, UIImage?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, NSError(domain: "FirebaseAuthService", code: 0, userInfo: [NSLocalizedDescriptionKey: "UID пользователя не найден"]), nil)
            return
        }
    }
}
//
//    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
//        Auth.auth().sendPasswordReset(withEmail: email) { error in
//            completion(error)
//        }
//    }
