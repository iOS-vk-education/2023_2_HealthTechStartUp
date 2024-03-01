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
    weak var viewController: UIViewController?
    weak var output: SignUpInteractorOutput?
    
    init(authService: AuthServiceDescription) {
        self.authService = authService
    }
}

extension SignUpInteractor: SignUpInteractorInput {
//    func authWithVKID(completion: @escaping (Result<Void, Error>) -> Void) {
//        guard let viewController = self.viewController else {
//            completion(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "ViewController is nil"])))
//            return
//        }
//        
//        authService.authWithVKID(with: viewController) { result in
//            completion(result)
//        }
//    }
        
    func authWithGoogle(completion: @escaping (Result<Void, Error>) -> Void) {
        guard let viewController = self.viewController else {
            completion(.failure(NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "ViewController is nil"])))
            return
        }
        
        authService.authWithGoogle(with: viewController) { result in
            completion(result)
        }
    }
}
