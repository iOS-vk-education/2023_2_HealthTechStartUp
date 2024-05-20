//
//  ChangePasswordPresenter.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

final class ChangePasswordPresenter {
    weak var view: ChangePasswordViewInput?
    weak var moduleOutput: ChangePasswordModuleOutput?
    
    private let router: ChangePasswordRouterInput
    private let interactor: ChangePasswordInteractorInput
    
    init(router: ChangePasswordRouterInput, interactor: ChangePasswordInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ChangePasswordPresenter: ChangePasswordModuleInput {
}

extension ChangePasswordPresenter: ChangePasswordViewOutput {
    
    func didTapConfirmButton(with oldPassword: String?, and newPassword: String?) {
        HapticService.shared.selectionVibrate()
        
        let validationErrors = Validator.validatePassword(for: oldPassword ?? "")
        if !validationErrors.isEmpty {
            view?.showAlert(with: .invalidPasswordWithRegExp(description: validationErrors.description))
            return
        }
        
        self.interactor.changePassword(oldPassword: oldPassword ?? "", newPassword: newPassword ?? "")
    }
    
    func didLoadView() {
        let viewModel = ChangePasswordViewModel()
        view?.configure(with: viewModel)
    }
    
    func getBack() {
        router.getBackToMainView()
    }
    
    func didTapOnForgotPasswordButton() {
        router.getForgotPasswordView()
    }
}

extension ChangePasswordPresenter: ChangePasswordInteractorOutput {
    func didChanged(_ result: Result<Void, any Error>, _ reauth: Bool?) {
        switch result {
        case .success:
            print("success")
            self.router.getBackToMainView()
        case .failure(let error):
            if reauth == nil {
                self.view?.showAlert(with: .fetchingUserError(error: error))
            } else if reauth == false {
                self.view?.showAlert(with: .invalidEmailOrPassword)
            }
        }
    }
}
