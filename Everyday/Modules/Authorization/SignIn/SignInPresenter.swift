//
//  SignInPresenter.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
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
    
    func didTapSignInButton(with email: String?, and password: String?) {
        if !Validator.isValidEmail(for: email ?? "") {
            view?.showAlert(with: "email", message: NSMutableAttributedString(string: ""))
            return
        }
        
        let validationErrors = Validator.validatePassword(for: password ?? "")
        if  validationErrors.length > 0 {
            view?.showAlert(with: "password", message: validationErrors)
            return
        }
        
        guard let email = email, let password = password else {
            return
        }
        
        interactor.loginWithEmail(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.router.openApp()
                case .failure(let error):
                    self.view?.showAlert(with: "network", message: NSMutableAttributedString(string: error.localizedDescription))
                }
            }
        }
    }
    
    func didTapSignWithGoogleButton() {
        interactor.loginWithGoogle() { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.router.openApp()
                case .failure(let error):
                    self.view?.showAlert(with: "network", message: NSMutableAttributedString(string: error.localizedDescription))
                }
            }
        }
    }
    
    func didTapSignSignWithVKButton() {
        AuthModel.shared.whichSign = .vk
    }
    
    func didTapSignSignWithAnonymButton() {
        AuthModel.shared.whichSign = .anonym
        // router.openApp()
    }
    
    
    func didLoadView() {
        let viewModel = SignInViewModel()
        view?.configure(with: viewModel)
    }
}

extension SignInPresenter: SignInInteractorOutput {
}
