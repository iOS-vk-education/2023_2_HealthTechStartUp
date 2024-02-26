//
//  SignInInteractor.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
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
    func loginWithGoogle(completion: @escaping (Result<Void, Error>) -> Void) {
        print("ok")
    }
    
    func loginWithEmail(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let model = SignInModel(email: email, password: password)
          
        authService.login(with: model) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
