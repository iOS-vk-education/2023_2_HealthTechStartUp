//
//  SignInInteractor.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//  
//

import UIKit

final class SignInInteractor {
    weak var output: SignInInteractorOutput?
    weak var viewController: UIViewController?
    let authService: AuthServiceDescription
    
    init(authService: AuthServiceDescription) {
        self.authService = authService
    }
}

extension SignInInteractor: SignInInteractorInput {
    func loginWithGoogle(with flag: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let viewController = self.viewController else {
            completion(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "ViewController is nil"])))
            return
        }
        
        if flag {
            authService.loginWithGoogle(with: viewController) { result in
                completion(result)
            }
        } else {
            authService.authWithGoogle(with: viewController) { result in
                completion(result)
            }
        }
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
    
    func loginWithEmail(email: String, password: String, flag: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        print("ok")
    }
    
    func userExists() {
        print("ok")
    }
}
