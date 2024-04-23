//
//  AuthorizationPresenter.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//  
//

import Foundation

final class AuthorizationPresenter {
    weak var view: AuthorizationViewInput?
    weak var moduleOutput: AuthorizationModuleOutput?
    
    private let router: AuthorizationRouterInput
    private let interactor: AuthorizationInteractorInput
    
    init(router: AuthorizationRouterInput, interactor: AuthorizationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension AuthorizationPresenter: AuthorizationModuleInput {
}

extension AuthorizationPresenter: AuthorizationViewOutput {
}

extension AuthorizationPresenter: AuthorizationInteractorOutput {
}
