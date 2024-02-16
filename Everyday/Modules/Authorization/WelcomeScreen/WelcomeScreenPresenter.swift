//
//  WelcomeScreenPresenter.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//  
//

import Foundation

final class WelcomeScreenPresenter {
    weak var view: WelcomeScreenViewInput?
    weak var moduleOutput: WelcomeScreenModuleOutput?
    
    private let router: WelcomeScreenRouterInput
    
    init(router: WelcomeScreenRouterInput) {
        self.router = router
    }
}

extension WelcomeScreenPresenter: WelcomeScreenModuleInput {
}

extension WelcomeScreenPresenter: WelcomeScreenViewOutput {
    func didLoadView() {
        let viewModel = WelcomeScreenViewModel()
        view?.configure(with: viewModel)
    }
    
    func getSignUp() {
        view?.setSignUp(router.getSignUpView())
    }
    
    func getSignIn() {
        view?.setSignIn(router.getSignInView())
    }
}
