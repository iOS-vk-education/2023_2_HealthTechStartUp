//
//  ProfileInteractor.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit

final class ProfileInteractor {
    weak var output: ProfileInteractorOutput?
    let authService: AuthServiceDescription
    
    init(authService: AuthServiceDescription) {
        self.authService = authService
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func updateUserName(username: String, completion: @escaping (Result<Void, Error>) -> Void) {
        authService.updateUserName(username: username) { result in
            completion(result)
        }
    }
    
    func getUserName(completion: @escaping (Result<Void, Error>, String) -> Void) {
        authService.getUserName { result, username  in
            guard let username = username else {
                return
            }
            completion(result, username)
        }
    }
    
    func getUserProfileImage(completion: @escaping (Result<Void, Error>, UIImage) -> Void) {
        authService.getUserProfileImage { result, userProfileImage in
            guard let userProfileImage = userProfileImage else {
                return
            }
            completion(result, userProfileImage)
        }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        authService.logout { result in
            completion(result)
        }
    }
}
