//
//  SignUpPresenter.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//  
//

import Foundation

final class SignUpPresenter {
    weak var view: SignUpViewInput?
    weak var moduleOutput: SignUpModuleOutput?
    
    private let router: SignUpRouterInput
    private let interactor: SignUpInteractorInput
    
    init(router: SignUpRouterInput, interactor: SignUpInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SignUpPresenter: SignUpModuleInput {
}

extension SignUpPresenter: SignUpViewOutput {
   
    func didLoadView() {
        let viewModel = SignUpViewModel()
        view?.configure(with: viewModel)
    }
    
    func didTapSignUpButton(with email: String?, and password: String?) {
        ProfileAcknowledgementModel.shared.email = email
        ProfileAcknowledgementModel.shared.password = password
        router.openOnBoarding()
    }
    
    func didTapSignWithVKButton() {
        interactor.authWithVKID()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.router.openOnBoarding()
        }
    }
    
    func didTapSignWithGoogleButton() {
        interactor.authWithGoogle()
    }
}

extension SignUpPresenter: SignUpInteractorOutput {
}
