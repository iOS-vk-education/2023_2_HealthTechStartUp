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
    
    private init() {
    }
    
    public func registerUser(with userRequest: ProfileAcknowledgementModel, completion: @escaping(Bool, Error?) -> Void) {
        let firstname = userRequest.firstname
        let lastname = userRequest.lastname
        let nickname = userRequest.nickname
        let profileImage = userRequest.profileImage
        let age = userRequest.age
        let gender = userRequest.gender
        let weight = userRequest.weight
        let schedule = userRequest.schedule
        let email = userRequest.email ?? ""
        let password = userRequest.password ?? ""

            switch AuthModel.shared.whichSign {
            case .google:
                guard let credential = AuthModel.shared.credential else {
                    completion(false, nil)
                    return
                }
                
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    guard let resultUser = result?.user else {
                        completion(false, nil)
                        return
                    }
                    
                    let db = Firestore.firestore()
                    
                    db.collection("user").document(resultUser.uid).setData([
                        "firstname": firstname ?? "",
                        "lastname": lastname ?? "",
                        "nickname": nickname ?? "",
                        "email": email,
                        "age": age ?? "",
                        "gender": gender ?? "",
                        "weight": weight ?? "",
                        "schedule": schedule
                    ]) { error in
                        if let error = error {
                            completion(false, error)
                            return
                        }
                        
                        completion(true, nil)
                    }
                }
            case .common:
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                                        
                    guard let resultUser = result?.user else {
                        completion(false, nil)
                        return
                    }
                    
                    let db = Firestore.firestore()
                    
                    db.collection("user").document(resultUser.uid).setData([
                        "firstname": firstname ?? "",
                        "lastname": lastname ?? "",
                        "nickname": nickname ?? "",
                        "email": email,
                        "age": age ?? "",
                        "gender": gender ?? "",
                        "weight": weight ?? "",
                        "schedule": schedule
                    ]) { error in
                        if let error = error {
                            completion(false, error)
                            return
                        }
                    }
                    completion(true, nil)
                }
            case .vk:
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                                        
                    guard let resultUser = result?.user else {
                        completion(false, nil)
                        return
                    }
                    
                    let db = Firestore.firestore()
                    
                    db.collection("user").document(resultUser.uid).setData([
                        "firstname": firstname ?? "",
                        "lastname": lastname ?? "",
                        "nickname": nickname ?? "",
                        "email": email,
                        "age": age ?? "",
                        "gender": gender ?? "",
                        "weight": weight ?? "",
                        "schedule": schedule
                    ]) { error in
                        if let error = error {
                            completion(false, error)
                            return
                        }
                    }
                    completion(true, nil)
                }
            default:
                completion(false, nil)
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
