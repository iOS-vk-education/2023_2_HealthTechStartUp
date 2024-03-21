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
    
    func didTapSignWithAnonymButton() {
        AuthModel.shared.whichSign = .anonym
        
        let generator = NameGenerator()
        
        ProfileAcknowledgementModel.shared.update(firstname: generator.generateName(),
                                                  lastname: generator.generateSurname())
        
        if CoreDataService.shared.isItemExists(for: "anonym") {
            view?.showAlert(with: "signed", message: NSMutableAttributedString(string: "AlertManager_signedUp_message".localized))
            return
        } else {
            router.openOnBoarding(with: "anonym")
        }
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
        if CoreDataService.shared.isItemExists(for: "email") {
            view?.showAlert(with: "signed", message: NSMutableAttributedString(string: "AlertManager_signedUp_message".localized))
            return
        } else {
            router.openOnBoarding(with: "email")
        }
    }
    
    func didTapSignWithVKButton() {
        AuthModel.shared.whichSign = .vk
        
        interactor.authWithVKID { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    if CoreDataService.shared.isItemExists(for: "vk") {
                        self.view?.showAlert(with: "signed", message: NSMutableAttributedString(string: "AlertManager_signedUp_message".localized))
                        return
                    } else {
                        self.router.openOnBoarding(with: "vk")
                    }
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
                    if CoreDataService.shared.isItemExists(for: "google") {
                        self.view?.showAlert(with: "signed", message: NSMutableAttributedString(string: "AlertManager_signedUp_message".localized))
                        return
                    } else {
                        self.router.openOnBoarding(with: "google")
                    }
                case .failure(let error):
                    self.view?.showAlert(with: "network", message: NSMutableAttributedString(string: error.localizedDescription))
                }
            }
        }
    }
}

extension SignUpPresenter: SignUpInteractorOutput {
}
