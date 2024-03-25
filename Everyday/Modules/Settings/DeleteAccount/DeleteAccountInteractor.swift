//
//  DeleteAccountInteractor.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class DeleteAccountInteractor {
    weak var output: DeleteAccountInteractorOutput?
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

extension DeleteAccountInteractor: DeleteAccountInteractorInput {
    func deleteAccount(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let model = DeleteAccountModel(email: email, password: password)
        authService.deleteAccount(with: model) {result in
            completion(result)
        }
    }
}
