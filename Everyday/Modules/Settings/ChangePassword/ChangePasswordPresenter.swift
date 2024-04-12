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
    
    private func handleChangePasswordResult(result: Result<Void, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                self.router.getBackToMainView()
            case .failure(let error):
                self.view?.showAlert(with: "network", message: error.localizedDescription)
            }
        }
    }
}

extension ChangePasswordPresenter: ChangePasswordModuleInput {
}

extension ChangePasswordPresenter: ChangePasswordViewOutput {
    
    func didTapConfirmButton(with oldPassword: String?, and newPassword: String?) {
        let validationErrors = Validator.validatePassword(for: oldPassword ?? "")
        if !validationErrors.isEmpty {
            view?.showAlert(with: Constants.invalidPassword, message: validationErrors)
        }
        
        DispatchQueue.main.async {
            self.interactor.changePassword(oldPassword: oldPassword ?? "", newPassword: newPassword ?? "") { [weak self] result in
                guard let self = self else {
                    return
                }
                self.handleChangePasswordResult(result: result)
            }
        }
    }
    
    func didLoadView() {
        let viewModel = ChangePasswordViewModel()
        view?.configure(with: viewModel)
    }
    
    func getBack() {
        router.getBackToMainView()
    }
    
    struct Constants {
        static let password: String = "password"
        static let invalidPassword: String = "Invalid password"
    }
}

extension ChangePasswordPresenter: ChangePasswordInteractorOutput {
}
