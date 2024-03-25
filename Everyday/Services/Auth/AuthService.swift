//
//  AuthService.swift
//  Everyday
//
//  Created by Михаил on 19.02.2024.
//

import UIKit

protocol AuthServiceDescription {
    func authWithVKID(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
    func authWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
    func authWithFirebase(with userRequest: ProfileAcknowledgementModel)
    
    func login(with userRequest: SignInModel, completion: @escaping (Result<Void, Error>) -> Void)
    func loginWithGoogle(with: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
    func loginWithVKID(with: UIViewController, completion: @escaping (Result<Void, Error>) -> Void)
    func loginWithAnonym(completion: @escaping (Result<Void, Error>) -> Void)
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
    
    func changeEmail(with userRequest: ChangeEmailModel, completion: @escaping (Result<Void, Error>) -> Void)
    func changePassword(with userRequest: ChangePasswordModel, completion: @escaping (Result<Void, Error>) -> Void)
    func deleteAccount(with userRequest: DeleteAccountModel, completion: @escaping (Result<Void, Error>) -> Void)
    func getUserName(completion: @escaping (Result<Void, Error>, String?) -> Void)
    func getUserProfileImage(completion: @escaping (Result<Void, Error>, UIImage?) -> Void)
    func updateUserName(username: String, completion: @escaping (Result<Void, Error>) -> Void)
}

final class AuthService: AuthServiceDescription {
    static let shared = AuthService()
    
    private let vkidAuthService: VKIDAuthServiceDescription
    private let googleAuthService: GoogleAuthServiceDescription
    private let firebaseAuthService: FirebaseAuthServiceDescription
    
    private init(vkidAuthService: VKIDAuthServiceDescription = VKIDAuthService.shared,
                 googleAuthService: GoogleAuthServiceDescription = GoogleAuthService.shared,
                 firebaseAuthService: FirebaseAuthServiceDescription = FirebaseAuthService.shared ) {
        self.vkidAuthService = vkidAuthService
        self.googleAuthService = googleAuthService
        self.firebaseAuthService = firebaseAuthService
    }
    
    func authWithVKID(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        vkidAuthService.authWithVKID(with: presentingController) { result in
            completion(result)
        }
    }
    
    func authWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        googleAuthService.authWithGoogle(with: presentingController) { result in
            completion(result)
        }
    }
    
    func authWithFirebase(with userRequest: ProfileAcknowledgementModel) {
        firebaseAuthService.registerUser(with: userRequest) { success, error in
            if let error = error {
                print("Registration failed with error: \(error.localizedDescription)")
            } else {
                print("Registration successful: \(success)")
            }
        }
    }
        
    func login(with userRequest: SignInModel, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseAuthService.login(with: userRequest) { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func loginWithGoogle(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        googleAuthService.loginWithGoogle(with: presentingController) { result in
            completion(result)
        }
    }
    
    func loginWithVKID(with presentingController: UIViewController, completion: @escaping (Result<Void, Error>) -> Void) {
        vkidAuthService.loginWithVKID(with: presentingController) { result in
            completion(result)
        }
    }
    
    func loginWithAnonym(completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseAuthService.anonymLogin { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseAuthService.signOut { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    func updateUserName(username: String, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseAuthService.updateNickname(username: username) { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getUserProfileImage(completion: @escaping (Result<Void, Error>, UIImage?) -> Void) {
        firebaseAuthService.fetchUserProfileImage { success, error, userProfileImage in
            if success {
                guard let userProfileImage = userProfileImage else {
                    return
                }
                completion(.success(()), userProfileImage)
            } else if let error = error {
                completion(.failure(error), nil)
            }
        }
    }
    
    func getUserName(completion: @escaping ((Result<Void, Error>), String?) -> Void) {
        firebaseAuthService.fetchUserName { success, error, username in
            if success {
                guard let username = username else {
                    return
                }
                completion(.success(()), username)
            } else if let error = error {
                completion(.failure(error), nil)
            }
        }
    }
    
    func changeEmail(with userRequest: ChangeEmailModel, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseAuthService.updateEmail(with: userRequest) { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func changePassword(with userRequest: ChangePasswordModel, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseAuthService.updatePassword(with: userRequest) { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func deleteAccount(with userRequest: DeleteAccountModel, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseAuthService.deleteAccount(with: userRequest) { success, error  in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
