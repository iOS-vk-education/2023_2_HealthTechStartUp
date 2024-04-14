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
        
    private func checkAuth(for service: String) -> Bool {
        return interactor.isAuthExist(for: service)
    }
}

// MARK: - SignInModuleInput
extension SignInPresenter: SignInModuleInput {
}

// MARK: - SignInViewOutput
extension SignInPresenter: SignInViewOutput {
    func didTapOnForgotPassword() {
        router.routeToForgotPasswordView()
    }
    
    func didTapSignInButton(with email: String?, and password: String?) {
        guard let email = email, Validator.isValidEmail(for: email) else {
            view?.showAlert(with: Constants.email, message: Constants.invalidEmail)
            return
        }
        
        let validationErrors = Validator.validatePassword(for: password ?? "")
        if !validationErrors.isEmpty {
            view?.showAlert(with: Constants.password, message: validationErrors)
            return
        }
        
        performSignIn(signInMethod: .email, authType: Constants.email, email: email, password: password ?? "")
    }
    
    func didTapSignInWithGoogleButton() {
        performSignIn(signInMethod: .google, authType: Constants.google)
    }
    
    func didTapSignInWithVKButton() {
        performSignIn(signInMethod: .vk, authType: Constants.vk)
    }
    
    func didTapSignInWithAnonymButton() {
        performSignIn(signInMethod: .anonym, authType: Constants.anonym)
    }
    
    private func performSignIn(signInMethod: AuthModel.Sign, authType: String, email: String = "", password: String = "") {
        let signedUp = checkAuth(for: authType)
        AuthModel.shared.whichSign = signInMethod
        
        if signInMethod == .anonym && !signedUp {
            let generator = NameGenerator()
            ProfileAcknowledgementModel.shared.update(firstname: generator.generateName(),
                                                      lastname: generator.generateSurname())
        }
                
        switch signInMethod {
        case .google:
            interactor.loginWithGoogle(with: signedUp)
            AuthUserDefaultsService.shared.setWhichSign(signMethod: .google)
        case .vk:
            interactor.loginWithVK(with: signedUp)
            AuthUserDefaultsService.shared.setWhichSign(signMethod: .vk)
        case .anonym:
            interactor.loginWithAnonym(with: signedUp)
            AuthUserDefaultsService.shared.setWhichSign(signMethod: .anonym)
        case .email:
            interactor.loginWithEmail(with: signedUp, email: email, password: password)
            AuthUserDefaultsService.shared.setWhichSign(signMethod: .email)
        default:
            break 
        }
    }
    
    func didLoadView() {
        let viewModel = SignInViewModel()
        view?.configure(with: viewModel)
    }
    
    // MARK: - Constants
    
    struct Constants {
        static let vk: String = "vk"
        static let google: String = "google"
        static let email: String = "email"
        static let anonym: String = "anonym"
        static let network: String = "network"
        static let password: String = "password"
        static let invalidEmail: String = "Invalid email"
    }
}

// MARK: - SignInInteractorOutput
extension SignInPresenter: SignInInteractorOutput {
    func authExistResult(isExists: Bool) -> Bool {
        return isExists
    }
    
    func authResult(signedUp: Bool, service: String, _ result: Result<Void, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                if signedUp {
                    self.router.openApp()
                } else {
                    self.router.openOnBoarding(with: service)
                }
            case .failure(let error):
                self.view?.showAlert(with: Constants.network, message: error.localizedDescription)
            }
        }
    }
}
