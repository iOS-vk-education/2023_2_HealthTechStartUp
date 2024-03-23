//
//  SignUpInteractor.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//  
//

import UIKit

final class SignUpInteractor {
    let authService: AuthServiceDescription
    let coreDataService: CoreDataServiceDescription
    weak var viewController: UIViewController?
    weak var output: SignUpInteractorOutput?
    
    init(authService: AuthServiceDescription, coreDataService: CoreDataServiceDescription) {
        self.authService = authService
        self.coreDataService = coreDataService
    }
}

extension SignUpInteractor: SignUpInteractorInput {
    func authWithVKID(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let viewController = self.viewController else {
            completion(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "ViewController is nil"])))
            return
        }
        
        authService.authWithVKID(with: viewController) { result in
            completion(result)
        }
    }
        
    func authWithGoogle(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let viewController = self.viewController else {
            completion(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "ViewController is nil"])))
            return
        }
        
        authService.authWithGoogle(with: viewController) { result in
            completion(result)
        }
    }
    
    func isAuthExist(for service: String) -> Bool {
        let isExists = coreDataService.isItemExists(for: service)
        return ((output?.authExistResult(isExists: isExists)) != nil)
    }
}
