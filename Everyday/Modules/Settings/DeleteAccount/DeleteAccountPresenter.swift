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
}

extension DeleteAccountPresenter: DeleteAccountModuleInput {
}

extension DeleteAccountPresenter: DeleteAccountViewOutput {
    func getWhichSign() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "WhichSign") ?? "email"
    }
    
    func didTapConfirmButton(with email: String?, and password: String?) {
        HapticService.shared.selectionVibrate()
        
        interactor.deleteAccount(email: email ?? "", password: password ?? "")
    }
    
    func didLoadView() {
        print(getWhichSign())
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
    func didDelete(_ result: Result<Void, any Error>, _ reauth: Bool?) {
        switch result {
        case .success:
            SettingsUserDefaultsService.shared.resetUserDefaults()
            SettingsUserDefaultsService.shared.setAutoTheme()
            Reloader.shared.setLogout()
            self.router.routeToAuthentication()
        case .failure(let error):
            if reauth == nil {
                self.view?.showAlert(with: .fetchingUserError(error: error))
            } else if reauth == false {
                self.view?.showAlert(with: .invalidEmailOrPassword)
            }
        }
    }
}
