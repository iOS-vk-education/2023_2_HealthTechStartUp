//
//  SignInInteractor.swift
//  Everyday
//
//  Created by Михаил on 27.04.2024.
//  
//

import Foundation

final class SignInInteractor {
    weak var output: SignInInteractorOutput?
    let authService: AuthServiceDescription
    
    init(authService: AuthServiceDescription) {
        self.authService = authService
    }
}

extension SignInInteractor: SignInInteractorInput {
    func authWithEmail(model: Email) {
        authService.loginWithEmail(with: model) { result in
            self.output?.didAuth(result)
        }
    }
}
