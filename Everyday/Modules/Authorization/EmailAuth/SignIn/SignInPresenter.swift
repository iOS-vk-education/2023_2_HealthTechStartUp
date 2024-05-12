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

    private func checkAuth(for service: String) -> Bool {
        return interactor.isAuthExist(for: service)
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

        if checkAuth(for: "email") {
            interactor.authWithEmail(model: model)
            AuthUserDefaultsService.shared.setWhichSign(signMethod: .common)
        } else {
            interactor.checkUserExist(with: model)
        }
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
    func didUserExist(_ model: Email, _ result: Result<Void, any Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.interactor.authWithEmail(model: model)
            case .failure(let error):
                if let nsError = error as NSError? {
                    if nsError.code != 0 {
                        self.view?.showAlert(with: .networkMessage(error: error))
                    }
                }
            }
        }
    }

    func didAuthExist(isExists: Bool) -> Bool {
        return isExists
    }

    func didAuth(_ result: Result<Void, any Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.set("email", forKey: "WhichSign")
                self.router.openApp()
            case .failure(let error):
                self.view?.showAlert(with: .networkMessage(error: error))
            }
        }
    }
}
