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
    
    private func checkAuth(for service: String) {
        let message = NSMutableAttributedString(string: "AlertManager_signedUp_message".localized)
        if CoreDataService.shared.isItemExists(for: service) {
            view?.showAlert(with: "signed", message: message)
            return
        } else {
            router.openOnBoarding(with: service)
        }
    }
}

extension SignUpPresenter: SignUpModuleInput {
}

extension SignUpPresenter: SignUpViewOutput {
    func didLoadView() {
        let viewModel = SignUpViewModel()
        view?.configure(with: viewModel)
    }
    
    func didTapSignWithAnonymButton() {
        AuthModel.shared.whichSign = .anonym
        
        let generator = NameGenerator()
        
        ProfileAcknowledgementModel.shared.update(firstname: generator.generateName(),
                                                  lastname: generator.generateSurname())
        checkAuth(for: "anonym")
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
        
        ProfileAcknowledgementModel.shared.update(email: email, password: password)
        checkAuth(for: "email")
    }
    
    func didTapSignWithVKButton() {
        AuthModel.shared.whichSign = .vk
        
        interactor.authWithVKID { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.checkAuth(for: "vk")
                case .failure(let error):
                    self.view?.showAlert(with: "network", message: NSMutableAttributedString(string: error.localizedDescription))
                }
            }
        }
    }

    func didTapSignWithGoogleButton() {
        AuthModel.shared.whichSign = .google
        
        interactor.authWithGoogle { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.checkAuth(for: "google")
                case .failure(let error):
                    self.view?.showAlert(with: "network", message: NSMutableAttributedString(string: error.localizedDescription))
                }
            }
        }
    }
}

extension SignUpPresenter: SignUpInteractorOutput {
}
