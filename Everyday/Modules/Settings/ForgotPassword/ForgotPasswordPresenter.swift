//
//  ForgotPasswordPresenter.swift
//  Everyday
//
//  Created by Yaz on 14.04.2024.
//

import Foundation

final class ForgotPasswordPresenter {
    weak var view: ForgotPasswordViewInput?
    weak var moduleOutput: ForgotPasswordModuleOutput?
    
    private let router: ForgotPasswordRouterInput
    private let interactor: ForgotPasswordInteractorInput
    
    init(router: ForgotPasswordRouterInput, interactor: ForgotPasswordInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    private func handleSendMessageResult(result: Result<Void, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(()):
                self.router.getBackToMainView()
            case .failure(let error):
                self.view?.showAlert(with: "network", message: error.localizedDescription)
            }
        }
    }
}

extension ForgotPasswordPresenter: ForgotPasswordModuleInput {
}

extension ForgotPasswordPresenter: ForgotPasswordViewOutput {
    func didTapConfirmButton(with email: String?) {
        guard let email = email, Validator.isValidEmail(for: email) else {
            view?.showAlert(with: Constants.email, message: Constants.invalidEmail)
            return
        }
        
        DispatchQueue.main.async {
            self.interactor.sendForgotPasswordMessage(with: email) { [weak self] result in
                guard let self = self else {
                    return
                }
                self.handleSendMessageResult(result: result)
            }
        }
    }
    
    func didSwipe() {
        router.getBackToMainView()
    }
    
    func didLoadView() {
        let viewModel = ForgotPasswordViewModel()
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

extension ForgotPasswordPresenter: ForgotPasswordInteractorOutput {
}
