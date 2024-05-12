//
//  ChangeEmailPresenter.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

final class ChangeEmailPresenter {
    weak var view: ChangeEmailViewInput?
    weak var moduleOutput: ChangeEmailModuleOutput?
    
    private let router: ChangeEmailRouterInput
    private let interactor: ChangeEmailInteractorInput
    
    init(router: ChangeEmailRouterInput, interactor: ChangeEmailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ChangeEmailPresenter: ChangeEmailModuleInput {
}

extension ChangeEmailPresenter: ChangeEmailViewOutput {
    func didTapOnForgotPasswordButton() {
        router.getForgotPasswordView()
    }
    
    func didTapConfirmButton(with email: String?, and password: String?) {
        guard let email = email, Validator.isValidEmail(for: email) else {
            view?.showAlert(with: Constants.email, message: Constants.invalidEmail)
            return
        }

        self.interactor.changeEmail(email: email, password: password ?? "")
    }
    
    func didLoadView() {
        let viewModel = ChangeEmailViewModel()
        view?.configure(with: viewModel)
    }
    
    func getBack() {
        router.getBackToMainView()
    }
    
    struct Constants {
        static let email: String = "email"
        static let invalidEmail: String = "Invalid email"
    }
}

extension ChangeEmailPresenter: ChangeEmailInteractorOutput {
    func didChanged(_ result: Result<Void, any Error>) {
        switch result {
        case .success(()):
            self.router.getBackToMainView()
        case .failure(let error):
            self.view?.showAlert(with: "network", message: error.localizedDescription)
        }
    }
}
