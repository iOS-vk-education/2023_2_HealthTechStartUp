//
//  FIrebaseAuthService.swift
//  Everyday
//
//  Created by Михаил on 20.02.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthModel {
    static let shared = AuthModel()
    
    enum Sign {
        case vk
        case google
        case common
        case none
    }
    
    var whichSign: Sign = .none
    
    private init() {
    }
}

protocol FirebaseAuthServiceDescription {
    func registerUser(with userRequest: ProfileAcknowledgementModel, completion: @escaping(Bool, Error?) -> Void)
    func login(with data: Email, completion: @escaping(Bool, Error?) -> Void)
    func signOut(completion: @escaping (Bool, Error?) -> Void)
    func forgotPassword(with email: String, completion: @escaping (Bool, Error?) -> Void)
    func userExist(with email: String, completion: @escaping (Bool, Error?) -> Void)
}

final class FirebaseAuthService: FirebaseAuthServiceDescription {
    public static let shared = FirebaseAuthService()
    
    private init() {}
    
    func forgotPassword(with email: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(false, error)
                return
            } else {
                completion(true, nil)
            }
        }
    }
    
    func userExist(with email: String, completion: @escaping (Bool, Error?) -> Void) {
        let collection = Firestore.firestore().collection("user")
        collection.whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if let error = error {
                completion(false, error)
                return
            } else {
                guard let query = snapshot, !query.isEmpty else {
                    completion(false, nil)
                    return
                }
                completion(true, nil)
            }
        }
    }
    
    func registerUser(with userRequest: ProfileAcknowledgementModel, completion: @escaping(Bool, Error?) -> Void) {
        switch AuthModel.shared.whichSign {
        case .google, .vk, .common:
            performAuth(userRequest: userRequest, completion: completion)
        default:
            completion(false, nil)
        }
    }
    
    func login(with data: Email, completion: @escaping (Bool, Error?) -> Void) {
        let email = data.email
        let password = data.password
        
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
                        "schedule": userRequest.schedule ?? DayServiceSchedule().dictionaryRepresentation,
                        "history": userRequest.history ?? [],
                        "profileImage": path,
                        "bodyWeightMeasureUnit": userRequest.bodyWeightMeasureUnit ?? "",
                        "measurementsMeasureUnit": userRequest.measurementsMeasureUnit ?? "",
                        "loadWeightMeasureUnit": userRequest.bodyWeightMeasureUnit ?? "",
                        "distanceMeasureUnit": userRequest.distanceMeasureUnit ?? "",
                        "featured": userRequest.featuredPrograms ?? [],
                        "downloaded": userRequest.downloadedPrograms ?? []
                    ]
                    
                    try await Firestore.firestore().collection("user").document(userId).setData(userData)
                    completion(true, nil)
                } catch {
                    completion(false, error)
                }
            }
        }
    }
}
