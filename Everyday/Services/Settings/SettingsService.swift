//
//  SettingsService.swift
//  Everyday
//
//  Created by Yaz on 29.03.2024.
//

import UIKit

protocol SettingsServiceDescription {
    func changeEmail(with userRequest: ChangeEmailModel, completion: @escaping (Result<Void, Error>, Bool?) -> Void)
    func changePassword(with userRequest: ChangePasswordModel, completion: @escaping (Result<Void, Error>, Bool?) -> Void)
    func getUserName(completion: @escaping (Result<Void, Error>, String?) -> Void)
    func getUserProfileImage() async throws -> UIImage?
    func deleteEmailAccount(with userRequest: DeleteAccountModel, whichSign: String, completion: @escaping (Result<Void, Error>, Bool?) -> Void)
    func deleteGoogleAccount(with whichSign: String, completion: @escaping (Result<Void, Error>) -> Void)
    func deleteVkAccount(with whichSign: String, completion: @escaping (Result<Void, Error>) -> Void)
    func updateUserImage(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void)
    func updateUserName(username: String, completion: @escaping (Result<Void, Error>) -> Void)
    func updateMeasureUnit(measureUnit: String, measureUnitKey: String, completion: @escaping (Result<Void, Error>) -> Void)
    func sendForgotPasswordMessage(email: String, completion: @escaping (Result<Void, Error>) -> Void)
}

final class SettingsService: SettingsServiceDescription {
    static let shared = SettingsService()
    
    private let firebaseService: FirebaseServiceDescription
    
    private init(firebaseService: FirebaseServiceDescription = FirebaseService.shared) {
        
        self.firebaseService = firebaseService
    }
    
    func updateUserName(username: String, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.updateNickname(username: username) { success, error in
            if let error = error {
                completion(.failure(error))
            } else if success {
                completion(.success(()))
            }
        }
    }
        
    func getUserProfileImage() async throws -> UIImage? {
        let userProfileImage = try await firebaseService.fetchUserProfileImage()
        return userProfileImage
    }

    
    func updateUserImage(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.updateUserImage(image: image) { success, error in
            if let error = error {
                completion(.failure(error))
            } else if success {
                completion(.success(()))
            }
        }
    }
    
    func updateMeasureUnit(measureUnit: String, measureUnitKey: String, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.updateMeasureUnit(measureUnit: measureUnit, measureUnitKey: measureUnitKey) { success, error in
            if let error = error {
                completion(.failure(error))
            } else if success {
                completion(.success(()))
            }
        }
    }
    
    func getUserName(completion: @escaping ((Result<Void, Error>), String?) -> Void) {
        firebaseService.fetchUserName { success, error, username in
            if let error = error {
                completion(.failure(error), nil)
            } else if success {
                guard let username = username else {
                    return
                }
                completion(.success(()), username)
            }
        }
    }
    
    func changeEmail(with userRequest: ChangeEmailModel, completion: @escaping (Result<Void, Error>, Bool?) -> Void) {
        firebaseService.updateEmail(with: userRequest) { success, error, reauth in
            if let error = error {
                completion(.failure(error), reauth)
            } else if success {
                completion(.success(()), reauth)
            }
        }
    }
    
    func deleteEmailAccount(with userRequest: DeleteAccountModel, whichSign: String, completion: @escaping (Result<Void, Error>, Bool?) -> Void) {
        let coreData = CoreDataService.shared
        firebaseService.deleteEmailAccount(email: userRequest.email, password: userRequest.password) { success, error, reauth  in
            if let error = error {
                completion(.failure(error), reauth)
            } else if success {
                self.firebaseService.signOut { _, error in
                    guard let error = error else {
                        KeychainService.clearOne(authType: "emailAuth")
                        coreData.deleteAuthType(authType: whichSign)
                        completion(.success(()), reauth)
                        return
                    }
                    completion(.failure(error), reauth)
                }
            }
        }
    }
    
    func deleteGoogleAccount(with whichSign: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        let coreData = CoreDataService.shared
        firebaseService.deleteGoogleAccount { success, error in
            if let error = error {
                completion(.failure(error))
            } else if success {
                self.firebaseService.signOut { _, error in
                    guard error == nil else {
                        completion(.failure(error!))
                        return
                    }
                }
                KeychainService.clearOne(authType: "googleAuth")
                coreData.deleteAuthType(authType: whichSign)
                completion(.success(()))
            }
        }
    }
    
    func deleteVkAccount(with whichSign: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        let coreData = CoreDataService.shared
        firebaseService.deleteVkAccount { success, error in
            if let error = error {
                completion(.failure(error))
            } else if success {
                self.firebaseService.signOut { _, error in
                    guard error == nil else {
                        completion(.failure(error!))
                        return
                    }
                }
                KeychainService.clearOne(authType: "vkAuth")
                coreData.deleteAuthType(authType: whichSign)
                completion(.success(()))
            }
        }
    }
    
    func changePassword(with userRequest: ChangePasswordModel, completion: @escaping (Result<Void, Error>, Bool?) -> Void) {
        firebaseService.updatePassword(with: userRequest) { success, error, reauth in
            if let error = error {
                completion(.failure(error), reauth)
            } else if success {
                completion(.success(()), reauth)
            }
        }
    }
    
    func sendForgotPasswordMessage(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.resetPassword(email: email) { success, error in
            if let error = error {
                completion(.failure(error))
            } else if success {
                completion(.success(()))
            }
        }
    }
}
