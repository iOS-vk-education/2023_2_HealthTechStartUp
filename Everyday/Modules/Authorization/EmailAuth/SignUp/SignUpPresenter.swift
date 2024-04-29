//
//  SignUpPresenter.swift
//  Everyday
//
//  Created by Михаил on 28.04.2024.
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
    func didTapSignupButton(with email: String, and password: String) {
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
        ProfileAcknowledgementModel.shared.update(email: email, password: password)   
        interactor.checkUserExist(with: email)
    }
    
    func didTapCloseButton() {
        router.closeView()
    }
    
    func didTapLoginButton() {
        router.openLogin()
    }
    
    func didLoadView() {
        let model = SignUpViewModel()
        view?.configure(with: model)
    }
}

extension SignUpPresenter: SignUpInteractorOutput {
    func didUserExist(_ result: Result<Void, any Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.view?.showAlert(with: .invalidEmail)
            case .failure(let error):
                if let nsError = error as NSError? {
                    if nsError.code == 0 {
                        self.router.openOnBoarding(with: "email")
                    }
                } else {
                    self.view?.showAlert(with: .networkMessage(error: error))
                }
            }
        }
    }
}
