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
    func authWithVKID(completion: @escaping () -> Void) {
        guard let viewController else {
            return
        }
        
        authService.authWithVKID(with: viewController)
        completion()
    }
    
    func authWithGoogle(completion: @escaping () -> Void) {
        guard let viewController else {
            return
        }
        
        authService.authWithGoogle(with: viewController)
        completion()
    }
}
