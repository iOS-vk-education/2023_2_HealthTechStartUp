//
//  AuthorizationPresenter.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//  
//

import Foundation

final class AuthorizationPresenter {
    weak var view: AuthorizationViewInput?
    weak var moduleOutput: AuthorizationModuleOutput?
    
    private let router: AuthorizationRouterInput
    private let interactor: AuthorizationInteractorInput
    
    init(router: AuthorizationRouterInput, interactor: AuthorizationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    private func checkAuth(for service: String) -> Bool {
        return interactor.isAuthExist(for: service)
    }
    
    private func setSignIn(with flag: Bool) {
        if flag {
            UserDefaults.standard.set("google", forKey: "WhichSign")
            KeychainService.saveString("google", for: "googleAuth")
            Reloader.shared.getAuthType()
        }
        
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        router.openApp()
    }
}

extension AuthorizationPresenter: AuthorizationModuleInput {
}

// MARK: - View Output

extension AuthorizationPresenter: AuthorizationViewOutput {
    func didLoadView() {
        let viewModel = AuthorizationViewModel()
        view?.configure(with: viewModel)
    }
    
    func didTapSignInWithEmailButton() {
        router.openEmailAuth()
    }
    
    func didTapSignInWithGoogleButton() {
        guard Locale.current.region?.identifier != "RU" else {
            DispatchQueue.main.async {
                self.view?.showAlert(with: .ruSignWithGoogle)
            }
            return
        }
        
        performSignIn(signInMethod: .google, authType: "google")
    }
    
    func didTapSignInWithVKButton() {
        performSignIn(signInMethod: .vk, authType: "vk")
    }
    
    func didTapSignInWithAppleButton() {
        DispatchQueue.main.async {
            self.view?.showAlert(with: .ruSignWithAppleID)
        }
    }
    
    private func performSignIn(signInMethod: AuthModel.Sign, authType: String) {
        let signedUp = checkAuth(for: authType)
        AuthModel.shared.whichSign = signInMethod
        
        switch signInMethod {
        case .google:
            interactor.authWithGoogle(with: signedUp)
        case .vk:
            interactor.authWithVK(with: signedUp)
            UserDefaults.standard.set("vk", forKey: "WhichSign")
        default:
            break
        }
    }
}

// MARK: - Interactor Output

extension AuthorizationPresenter: AuthorizationInteractorOutput {
    func didAuth(signedUp: Bool, service: String, _ result: Result<Void, any Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                if signedUp {
                    self.setSignIn(with: false)
                } else {
                    if AuthModel.shared.whichSign == .google && GoogleAuthService.shared.authed {
                        self.setSignIn(with: true)
                    } else {
                        self.router.openOnBoarding(with: service)
                    }
                }
            case .failure(let error):
                self.view?.showAlert(with: .networkMessage(error: error))
            }
        }
    }
    
    func didAuthExist(isExists: Bool) -> Bool {
        return isExists
    }
}
