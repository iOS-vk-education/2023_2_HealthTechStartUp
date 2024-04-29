//
//  SignInPresenter.swift
//  Everyday
//
//  Created by Михаил on 27.04.2024.
//  
//

import Foundation

final class SignInPresenter {
    weak var view: SignInViewInput?
    weak var moduleOutput: SignInModuleOutput?
    
    private let router: SignInRouterInput
    private let interactor: SignInInteractorInput
    
    init(router: SignInRouterInput, interactor: SignInInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SignInPresenter: SignInModuleInput {
}

extension SignInPresenter: SignInViewOutput {
    func didTapForgotPasswordButton() {
        router.openForgot()
    }
    
    func didTapCloseButton() {
        router.closeView()
    }
    
    func didTapLoginButton(with email: String, and password: String) {
        guard Validator.isValidEmail(for: email) else {
            view?.showAlert(with: .invalidEmail)
            return
        }
    
        let validationErrors = Validator.validatePassword(for: password)
        if !validationErrors.isEmpty {
            view?.showAlert(with: .invalidPasswordWithRegExp(description: validationErrors))
            return
        }
        
        AuthModel.shared.whichSign = .common
        let model = Email(email: email, password: password)
        
        interactor.authWithEmail(model: model)
    }
    
    func didLoadView() {
        let model = SignInViewModel()
        view?.configure(with: model)
    }
    
    func didTapSignupButton() {
        router.openSignup()
    }
}

// MARK: - interactor output

extension SignInPresenter: SignInInteractorOutput {
    func didAuth(_ result: Result<Void, any Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.router.openApp()
            case .failure(let error):
                self.view?.showAlert(with: .networkMessage(error: error))
            }
        }
    }
}
