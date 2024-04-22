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
        guard Locale.current.region?.identifier != "RU" else {
            view?.showAlert(with: Constants.google, message: "")
            return
        }
        
        performSignIn(signInMethod: .google, authType: Constants.google)
    }
        
    func didTapSignInWithVKButton() {
        performSignIn(signInMethod: .vk, authType: Constants.vk)
    }
    
    func didTapSignInWithAppleButton() {
        view?.showAlert(with: Constants.appleInfo, message: "")
    }
    
    private func performSignIn(signInMethod: AuthModel.Sign, authType: String, email: String = "", password: String = "") {
        let signedUp = checkAuth(for: authType)
        AuthModel.shared.whichSign = signInMethod
        
        switch signInMethod {
        case .google:
            interactor.loginWithGoogle(with: signedUp)
        case .vk:
            interactor.loginWithVK(with: signedUp)
        case .email:
            interactor.loginWithEmail(with: signedUp, email: email, password: password)
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
        static let apple: String = "apple"
        static let appleInfo: String = "appleInfo"
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
