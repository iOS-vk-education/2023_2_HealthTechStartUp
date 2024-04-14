//
//  DeleteAccountPresenter.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

final class DeleteAccountPresenter {
    weak var view: DeleteAccountViewInput?
    weak var moduleOutput: DeleteAccountModuleOutput?
    
    private let router: DeleteAccountRouterInput
    private let interactor: DeleteAccountInteractorInput
    
    init(router: DeleteAccountRouterInput, interactor: DeleteAccountInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    private func handleDeleteAccountResult(result: Result<Void, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                SettingsUserDefaultsService.shared.resetUserDefaults()
                SettingsUserDefaultsService.shared.setAutoTheme()
                self.router.routeToAuthentication()
            case .failure(let error):
                self.view?.showAlert(with: "network", message: error.localizedDescription)
            }
        }
    }
}

extension DeleteAccountPresenter: DeleteAccountModuleInput {
}

extension DeleteAccountPresenter: DeleteAccountViewOutput {
    func getWhichSign() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "WhichSign") ?? "email"
    }
    
    func didTapConfirmButton(with email: String?, and password: String?) {
            interactor.deleteAccount(email: email ?? "", password: password ?? "") { [weak self] result in
                guard let self = self else {
                    return
                }
                self.handleDeleteAccountResult(result: result)
            }
    }
    
    func didLoadView() {
        let viewModel = DeleteAccountViewModel()
        view?.configure(with: viewModel)
    }
    
    func getBack() {
        router.getBackToMainView()
    }
    
    func didTapOnForgotPasswordButton() {
        router.getForgotPasswordView()
    }
    
    struct Constants {
        static let invalidEmail: String = "Invalid Email"
        static let invalidPassword: String = "Invalid password"
    }
}

extension DeleteAccountPresenter: DeleteAccountInteractorOutput {
}
