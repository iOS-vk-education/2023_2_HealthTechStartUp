//
//  ProfilePresenter.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation
import UIKit

final class ProfilePresenter {
    weak var view: ProfileViewInput?
    weak var moduleOutput: ProfileModuleOutput?
    
    private let router: ProfileRouterInput
    private let interactor: ProfileInteractorInput
    
    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    private func handleFetchUser(result: Result<Void, Error>, userProfileImage: UIImage) {
        switch result {
        case .success:
            self.view?.setupProfileImage(image: userProfileImage)
        case .failure(let error):
            self.view?.showAlert(with: "image", message: error.localizedDescription)
        }
    }
}

extension ProfilePresenter: ProfileModuleInput {
}

extension ProfilePresenter: ProfileViewOutput {
    func getWhichSing() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "WhichSign") ?? "email"
    }
    func getProfileViewModelSingWithEmail() -> ProfileViewModelSingWithEmail {
        let model = ProfileViewModelSingWithEmail()
        return model
    }
    
    func getProfileViewModelSingWithVKOrGoogle() -> ProfileViewModelSingWithVKOrGoogle {
        let model = ProfileViewModelSingWithVKOrGoogle()
        return model
    }
    
    func didTapChangeUserImageButton(image: UIImage?, error: Error?) {
        if let error = error {
            self.view?.showAlert(with: "DownloadImageError", message: error.localizedDescription)
            return
        }
        
        guard let image = image else {
            self.view?.showAlert(with: "DownloadImageError", message: "Изображение не найдено")
            return
        }

        interactor.updateUserImage(image: image) { result in
            switch result {
            case .success: print("Success")
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showAlert(with: "ErrorUpdateImage", message: error.localizedDescription)
                }
            }
        }
    }

    func updateUserName(username: String) {
        interactor.updateUserName(username: username) { result in
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

    func didTapLogoutButton() {
        interactor.logout { result in
            SettingsUserDefaultsService.shared.setAutoTheme()
            DispatchQueue.main.async {
                switch result {
                case .success:
                    SettingsUserDefaultsService.shared.resetUserDefaults()
                    self.router.routeToAuthentication()
                case .failure(let error):
                    self.view?.showAlert(with: "logout", message: error.localizedDescription)
                }
            }
        }
    }
    
    func getUsername(completion: @escaping (String?) -> Void) {
        interactor.getUserName { result, username in
            switch result {
            case .success(()):
                completion(username)
            case .failure(let error):
                self.view?.showAlert(with: "getUsernameError", message: error.localizedDescription)
            }
        }
    }
    
    func didLoadView() {
        interactor.getUserProfileImage { [weak self] result, userProfileImage in
            guard let self = self else {
                return
            }
            self.handleFetchUser(result: result, userProfileImage: userProfileImage)
        }
        
        self.view?.configure(with: ProfileViewModel())
    }
    
    func didSwipe() {
        router.getBackToMainView()
    }
    
    func didTapChangeEmailCell() {
        router.getChangeEmailView()
    }
    
    func didTapChangePasswordCell() {
        router.getChangePasswordView()
    }
    
    func didTapDeleteAccountCell() {
        router.getDeleteAccountView()
    }
}

extension ProfilePresenter: ProfileInteractorOutput {
}
