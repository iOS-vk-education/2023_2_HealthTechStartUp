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
    let coreDataService: CoreDataServiceDescription
    
    init(authService: AuthServiceDescription, coreDataService: CoreDataServiceDescription) {
        self.authService = authService
        self.coreDataService = coreDataService
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
    func loginWithGoogle(with flag: Bool) {
        guard let viewController = self.viewController else {
            output?.authResult(signedUp: flag, service: "google", .failure(SignError.viewControllerNil))
            return
        }
        
        performAuthAction(flag: flag, viewController: viewController,
                          action: flag ? authService.loginWithGoogle : authService.authWithGoogle) { result in
            self.output?.authResult(signedUp: flag, service: "google", result)
        }
    }
    
    func loginWithEmail(with flag: Bool, email: String, password: String) {
        let model = SignInModel(email: email, password: password)
        authService.login(with: model) { result in
            self.output?.authResult(signedUp: flag, service: "email", result)
        }
    }

    func loginWithVK(with flag: Bool) {
        guard let viewController = self.viewController else {
            output?.authResult(signedUp: flag, service: "vk", .failure(SignError.viewControllerNil))
            return
        }
        
        performAuthAction(flag: flag, viewController: viewController,
                          action: flag ? authService.loginWithVKID : authService.authWithVKID) { result in
            self.output?.authResult(signedUp: flag, service: "vk", result)
        }
    }
    
    func loginWithAnonym(with flag: Bool) {
        if flag {
            authService.loginWithAnonym { result in
                self.output?.authResult(signedUp: flag, service: "anonym", result)
            }
        } else {
            output?.authResult(signedUp: flag, service: "anonym", .success(()))
        }
    }
    
    func isAuthExist(for service: String) -> Bool {
        let isExists = coreDataService.isItemExists(for: service)
        return output?.authExistResult(isExists: isExists) ?? false
    }
}
