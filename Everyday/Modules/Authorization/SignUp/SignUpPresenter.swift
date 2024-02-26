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
        AuthModel.shared.whichSign = .common
        
        if !Validator.isValidEmail(for: email ?? "") {
            view?.showAlert(with: "email", message: NSMutableAttributedString(string: ""))
            return
        }
        
        let validationErrors = Validator.validatePassword(for: password ?? "")
        if  validationErrors.length > 0 {
            view?.showAlert(with: "password", message: validationErrors)
            return
        }
        
        ProfileAcknowledgementModel.shared.email = email
        ProfileAcknowledgementModel.shared.password = password
        router.openOnBoarding()
    }
    
    func didTapSignWithVKButton() {
        AuthModel.shared.whichSign = .vk
        
        interactor.authWithVKID {
            DispatchQueue.main.async {
                self.router.openOnBoarding()
            }
        }
    }

    func didTapSignWithGoogleButton() {
        AuthModel.shared.whichSign = .google
        
        interactor.authWithGoogle { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.router.openOnBoarding()
                    case .failure(let error):
                        self.view?.showAlert(with: "network", message: NSMutableAttributedString(string: error.localizedDescription))
                    }
                }
        }
    }
}

extension SignUpPresenter: SignUpInteractorOutput {
}
