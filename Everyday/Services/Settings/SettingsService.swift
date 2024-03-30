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
    func deleteAccount(with userRequest: DeleteAccountModel, completion: @escaping (Result<Void, Error>) -> Void)
    func getUserName(completion: @escaping (Result<Void, Error>, String?) -> Void)
    func getUserProfileImage(completion: @escaping (Result<Void, Error>, UIImage?) -> Void)
    func updateUserImage(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void)
    func updateUserName(username: String, completion: @escaping (Result<Void, Error>) -> Void)
}

final class SettingsService: SettingsServiceDescription {
    static let shared = SettingsService()
    
    private let firebaseService: FirebaseServiceDescription
    
    private init(firebaseService: FirebaseServiceDescription = FirebaseService.shared) {
        
        self.firebaseService = firebaseService
    }
    
    func updateUserName(username: String, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.updateNickname(username: username) { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getUserProfileImage(completion: @escaping (Result<Void, Error>, UIImage?) -> Void) {
        firebaseService.fetchUserProfileImage { success, error, userProfileImage in
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
    
    func updateUserImage(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.updateUserImage(image: image) { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getUserName(completion: @escaping ((Result<Void, Error>), String?) -> Void) {
        firebaseService.fetchUserName { success, error, username in
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
        firebaseService.updateEmail(with: userRequest) { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func changePassword(with userRequest: ChangePasswordModel, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.updatePassword(with: userRequest) { success, error in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func deleteAccount(with userRequest: DeleteAccountModel, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.deleteAccount(with: userRequest) { success, error  in
            if success {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
