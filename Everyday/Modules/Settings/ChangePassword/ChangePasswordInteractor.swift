//
//  ChangePasswordInteractor.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class ChangePasswordInteractor {
    weak var output: ChangePasswordInteractorOutput?
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

extension ChangePasswordInteractor: ChangePasswordInteractorInput {
    func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let model = ChangePasswordModel(oldPassword: oldPassword, newPassword: newPassword)
        authService.changePassword(with: model) {result in
                completion(result)
        }
    }
}
