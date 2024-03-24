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
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        authService.logout { result in
            completion(result)
        }
    }
}
