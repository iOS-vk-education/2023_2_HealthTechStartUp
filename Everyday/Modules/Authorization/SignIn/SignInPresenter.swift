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
    
    private func handleLoginResult(signedUp: Bool, result: Result<Void, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                if signedUp {
                    self.router.openApp()
                } else {
                    self.router.openOnBoarding()
                }
            case .failure(let error):
                self.view?.showAlert(with: "network", message: NSMutableAttributedString(string: error.localizedDescription))
            }
        }
    }
}

// MARK: - SignInModuleInput
extension SignInPresenter: SignInModuleInput {
}

// MARK: - SignInViewOutput
extension SignInPresenter: SignInViewOutput {
    
    func didTapSignInButton(with email: String?, and password: String?) {
        guard let email = email, Validator.isValidEmail(for: email) else {
            view?.showAlert(with: "email", message: NSMutableAttributedString(string: "Invalid email"))
            return
        }
        
        let validationErrors = Validator.validatePassword(for: password ?? "")
        if validationErrors.length > 0 {
            view?.showAlert(with: "password", message: validationErrors)
            return
        }
        
        interactor.loginWithEmail(email: email, password: password ?? "") { [weak self] result in
            guard let self = self else {
                return
            }
            self.handleLoginResult(signedUp: UserDefaults.standard.bool(forKey: "HasCompletedOnboarding"), result: result)
        }
    }
    
    func didTapSignInWithGoogleButton() {
        performSignIn(signInMethod: .google)
    }
    
    func didTapSignInWithVKButton() {
        performSignIn(signInMethod: .vk)
    }
    
    func didTapSignInWithAnonymButton() {
        performSignIn(signInMethod: .anonym)
    }
    
    private func performSignIn(signInMethod: AuthModel.Sign) {
        let signedUp = UserDefaults.standard.bool(forKey: "HasCompletedOnboarding")
        AuthModel.shared.whichSign = signInMethod
        
        let completion: (Result<Void, Error>) -> Void = { [weak self] result in
            guard let self = self else {
                return
            }
            self.handleLoginResult(signedUp: signedUp, result: result)
        }
        
        if signInMethod == .anonym && !signedUp {
            let generator = NameGenerator()
            ProfileAcknowledgementModel.shared.update(firstname: generator.generateName(),
                                                      lastname: generator.generateSurname())
        }
                
        switch signInMethod {
        case .google:
            interactor.loginWithGoogle(with: signedUp, completion: completion)
        case .vk:
            interactor.loginWithVK(with: signedUp, completion: completion)
        case .anonym:
            interactor.loginWithAnonym(with: signedUp, completion: completion)
        default:
            break // or handle other cases if needed
        }
    }
    
    func didLoadView() {
        let viewModel = SignInViewModel()
        view?.configure(with: viewModel)
    }
}

// MARK: - SignInInteractorOutput
extension SignInPresenter: SignInInteractorOutput {
}
