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
    func authWithGoogle() {
        guard let viewController = self.viewController else {
            let error = NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "ViewController is nil"])
            output?.authResult(service: "google", .failure(error))
            return
        }
        
        authService.authWithGoogle(with: viewController) { [weak self] result in
            guard let self = self else {
                return
            }
            self.output?.authResult(service: "google", result)
        }
    }
    
    func authWithVKID() {
       guard let viewController = self.viewController else {
           let error = NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "ViewController is nil"])
           output?.authResult(service: "vk", .failure(error))
           return
       }
       
       authService.authWithVKID(with: viewController) { [weak self] result in
           guard let self = self else {
               return
           }
           self.output?.authResult(service: "vk", result)
       }
    }
            
    func isAuthExist(for service: String) -> Bool {
        let isExists = coreDataService.isItemExists(for: service)
        return output?.authExistResult(isExists: isExists) ?? false
    }
}
