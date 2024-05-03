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
    let coreDataService: CoreDataServiceDescription
    
    init(authService: AuthServiceDescription, coreDataService: CoreDataServiceDescription) {
        self.authService = authService
        self.coreDataService = coreDataService
    }
}

extension SignInInteractor: SignInInteractorInput {
    func checkUserExist(with model: Email) {
        authService.userExist(with: model.email) { result in
            self.output?.didUserExist(model, result)
        }
    }
    
    func authWithEmail(model: Email) {
        authService.loginWithEmail(with: model) { result in
            self.output?.didAuth(result)
        }
    }
    
    func isAuthExist(for service: String) -> Bool {
        Reloader.shared.getAuthType()
        let isExists = coreDataService.isItemExists(for: service)
        return output?.didAuthExist(isExists: isExists) ?? false
    }
}
