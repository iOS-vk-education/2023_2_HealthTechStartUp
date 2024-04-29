//
//  AuthorizationInteractor.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//  
//

import UIKit

enum AuthErrors: Error {
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

final class AuthorizationInteractor {
    weak var output: AuthorizationInteractorOutput?
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

extension AuthorizationInteractor: AuthorizationInteractorInput {
    func authWithVK(with flag: Bool) {
        guard let viewController = self.viewController else {
            output?.didAuth(signedUp: flag, service: "vk", .failure(AuthErrors.viewControllerNil))
            return
        }
        
        performAuthAction(flag: flag, viewController: viewController,
                          action: flag ? authService.loginWithVKID : authService.authWithVKID) { result in
            self.output?.didAuth(signedUp: flag, service: "vk", result)
        }
    }
    
    func authWithGoogle(with flag: Bool) {
        guard let viewController = self.viewController else {
            output?.didAuth(signedUp: flag, service: "google", .failure(AuthErrors.viewControllerNil))
            return
        }
        
        performAuthAction(flag: flag, viewController: viewController,
                          action: flag ? authService.loginWithGoogle : authService.authWithGoogle) { result in
            self.output?.didAuth(signedUp: flag, service: "google", result)
        }
    }
        
    func isAuthExist(for service: String) -> Bool {
        let isExists = coreDataService.isItemExists(for: service)
        return output?.didAuthExist(isExists: isExists) ?? false
    }
}
