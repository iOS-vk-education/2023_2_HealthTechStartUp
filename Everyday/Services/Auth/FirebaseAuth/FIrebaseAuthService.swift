//
//  FIrebaseAuthService.swift
//  Everyday
//
//  Created by Михаил on 20.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum Sign {
    case vk
    case google
    case common
    case anonym
}

class AuthModel {
    static let shared = AuthModel()
    
    var whichSign: Sign?
    var credential: AuthCredential?

    init() {
    }
}

protocol FirebaseAuthServiceDescription {
    func registerUser(with userRequest: ProfileAcknowledgementModel, completion: @escaping(Bool, Error?) -> Void)
    // func login(with userRequest: LoginModel, completion: @escaping (Error?) -> Void)
    // func signOut(completion: @escaping (Error?) -> Void)
    // func forgotPassword(with email: String, completion: @escaping (Error?) -> Void)
    
}

class FirebaseAuthService: FirebaseAuthServiceDescription {
    public static let shared = FirebaseAuthService()
    
    private init() {}

    public func registerUser(with userRequest: ProfileAcknowledgementModel, completion: @escaping(Bool, Error?) -> Void) {
        switch AuthModel.shared.whichSign {
        case .google, .vk, .common, .anonym:
            performAuth(userRequest: userRequest, completion: completion)
        default:
            completion(false, nil)
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
            guard let credential = AuthModel.shared.credential else {
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
        let db = Firestore.firestore()
        let userData: [String: Any] = [
            "firstname": userRequest.firstname ?? "",
            "lastname": userRequest.lastname ?? "",
            "nickname": userRequest.nickname ?? "",
            "email": userRequest.email ?? "",
            "age": userRequest.age ?? "",
            "gender": userRequest.gender ?? "",
            "weight": userRequest.weight ?? "",
            "schedule": userRequest.schedule
        ]
        
        db.collection("user").document(resultUser.uid).setData(userData) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}

//    public func logIn(with userRequest: LoginModel, completion: @escaping (Error?) -> Void) {
//        Auth.auth().signIn(
//            withEmail: userRequest.email,
//            password: userRequest.password
//        ) { _, error in
//            if let error = error {
//                completion(error)
//                return
//            } else {
//                completion(nil)
//            }
//        }
//    }
//    
//    public func signOut(completion: @escaping (Error?) -> Void) {
//        do {
//            try Auth.auth().signOut()
//            completion(nil)
//        } catch let error {
//            completion(error)
//        }
//    }
//    
//    public func forgotPassword(with email: String, completion: @escaping (Error?) -> Void) {
//        Auth.auth().sendPasswordReset(withEmail: email) { error in
//            completion(error)
//        }
//    }
