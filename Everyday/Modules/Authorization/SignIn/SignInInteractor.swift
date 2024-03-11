//
//  SignInInteractor.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//  
//

import UIKit

enum SignError: Error {
    case viewControllerNil
    case other(Error)
    
    var localizedDescription: String {
        switch self {
        case .viewControllerNil:
            return "ViewController is nil"
        case .other(let error):
            return error.localizedDescription
        }
    }
}

final class SignInInteractor {
    weak var output: SignInInteractorOutput?
    weak var viewController: UIViewController?
    let authService: AuthServiceDescription
    
    init(authService: AuthServiceDescription) {
        self.authService = authService
    }
    
    private func performAuthAction(flag: Bool, viewController: UIViewController, 
                                   action: (_ viewController: UIViewController, _ completion: @escaping (Result<Void, Error>) -> Void) -> Void,
                                   completion: @escaping (Result<Void, Error>) -> Void) {
        action(viewController) { result in
            completion(result)
        }
    }
}

extension SignInInteractor: SignInInteractorInput {
    func loginWithGoogle(with flag: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let viewController = self.viewController else {
            completion(.failure(SignError.viewControllerNil))
            return
        }
        
        performAuthAction(flag: flag, viewController: viewController, 
                          action: flag ? authService.loginWithGoogle : authService.authWithGoogle, completion: completion)
    }
    
    func loginWithEmail(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let model = SignInModel(email: email, password: password)
        authService.login(with: model) { result in
            completion(result)
        }
    }
    
    func loginWithVK(with flag: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let viewController = self.viewController else {
            completion(.failure(SignError.viewControllerNil))
            return
        }
        
        performAuthAction(flag: flag, viewController: viewController, 
                          action: flag ? authService.loginWithVKID : authService.authWithVKID, completion: completion)
    }
    
    func loginWithAnonym(with flag: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        if flag {
            authService.loginWithAnonym(completion: completion)
        } else {
            completion(.success(()))
        }
    }
}
