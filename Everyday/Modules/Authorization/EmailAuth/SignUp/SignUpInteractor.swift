//
//  SignUpInteractor.swift
//  Everyday
//
//  Created by Михаил on 28.04.2024.
//  
//

import Foundation

final class SignUpInteractor {
    weak var output: SignUpInteractorOutput?
    let authService: AuthServiceDescription
    
    init(authService: AuthServiceDescription) {
        self.authService = authService
    }
}

extension SignUpInteractor: SignUpInteractorInput {
    func checkUserExist(with email: String) {
        authService.userExist(with: email) { result in
            self.output?.didUserExist(result)
        }
    }
}
