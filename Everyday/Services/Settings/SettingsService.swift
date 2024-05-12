//
//  SettingsService.swift
//  Everyday
//
//  Created by Yaz on 29.03.2024.
//

import UIKit

protocol SettingsServiceDescription {
    func changeEmail(with userRequest: ChangeEmailModel, completion: @escaping (Result<Void, Error>) -> Void)
    func changePassword(with userRequest: ChangePasswordModel, completion: @escaping (Result<Void, Error>) -> Void)
    func getUserName(completion: @escaping (Result<Void, Error>, String?) -> Void)
    func getUserProfileImage(completion: @escaping (Result<Void, Error>, UIImage?) -> Void)
    func deleteEmailAccount(with userRequest: DeleteAccountModel, whichSign: String, completion: @escaping (Result<Void, Error>) -> Void)
    func deleteAnonymAccount(with whichSign: String, completion: @escaping (Result<Void, Error>) -> Void)
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
    
    func getUserProfileImage(completion: @escaping (Result<Void, Error>, UIImage?) -> Void) {
        firebaseService.fetchUserProfileImage { success, error, userProfileImage in
            if let error = error {
                completion(.failure(error), nil)
            } else if success {
                guard let userProfileImage = userProfileImage else {
                    return
                }
                completion(.success(()), userProfileImage)
            }
        }
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
    
    func changeEmail(with userRequest: ChangeEmailModel, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.updateEmail(with: userRequest) { success, error in
            if let error = error {
                completion(.failure(error))
            } else if success {
                completion(.success(()))
            }
        }
    }
    
    func deleteEmailAccount(with userRequest: DeleteAccountModel, whichSign: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let coreData = CoreDataService.shared
        firebaseService.deleteEmailAccount(email: userRequest.email, password: userRequest.password) { success, error  in
            if let error = error {
                completion(.failure(error))
            } else if success {
                self.firebaseService.signOut { _, error in
                    guard let error = error else {
                        KeychainService.clearOne(authType: "emailAuth")
                        coreData.deleteAuthType(authType: whichSign)
                        completion(.success(()))
                        return
                    }
                    completion(.failure(error))
                }
            }
        }
    }
    
    func deleteAnonymAccount(with whichSign: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let coreData = CoreDataService.shared
        firebaseService.deleteAnonymAccount { success, error  in
            if let error = error {
                completion(.failure(error))
            } else if success {
                self.firebaseService.signOut { _, error in
                    guard error == nil else {
                        completion(.failure(error!))
                        return
                    }
                }
                KeychainService.clearOne(authType: "anonymAuth")
                coreData.deleteAuthType(authType: whichSign)
                completion(.success(()))
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
    
    func changePassword(with userRequest: ChangePasswordModel, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.updatePassword(with: userRequest) { success, error in
            if let error = error {
                completion(.failure(error))
            } else if success {
                completion(.success(()))
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
