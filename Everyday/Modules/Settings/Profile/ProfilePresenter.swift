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
    
    private func handleUpdateImageError(_ error: Error?) {
        let error = error?.localizedDescription ?? ""
        self.view?.showAlert(with: "DownloadImageError", message: error)
    }
    
    private func handleFetchUserImage(result: Result<Void, Error>, userProfileImage: UIImage) {
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
    func getWhichSign() -> String {
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
        DispatchQueue.main.async {
            if let error = error {
                self.handleUpdateImageError(error)
                return
            }
            
            guard let image = image else {
                self.handleUpdateImageError(nil)
                return
            }
            
            self.interactor.updateUserImage(image: image) { result in
                switch result {
                case .success: print("Success update image")
                case .failure(let error):
                    self.handleUpdateImageError(error)
                }
            }
        }
    }
    
    func updateUserName(username: String) {
        DispatchQueue.main.async {
            self.interactor.updateUserName(username: username) { result in
                switch result {
                case .success:
                    SettingsUserDefaultsService.shared.setUserName(username: username)
                case .failure(let error):
                    self.view?.showAlert(with: "network", message: error.localizedDescription)
                }
            }
        }
    }
    
    func didTapLogoutButton() {
        DispatchQueue.main.async {
            self.interactor.logout { result in
                SettingsUserDefaultsService.shared.setAutoTheme()
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        SettingsUserDefaultsService.shared.resetUserDefaults()
                        Reloader.shared.setLogout()
                        self.router.getBackToMainView()
                    case .failure(let error):
                        self.view?.showAlert(with: "logout", message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getUsername(completion: @escaping (String?) -> Void) {
        DispatchQueue.main.async {
            let settingsUserDefaults = SettingsUserDefaultsService.shared
            let currentUserName = settingsUserDefaults.getUserName()
            completion(currentUserName)
            
            self.interactor.getUserName { result, username in
                if username != currentUserName {
                    switch result {
                    case .success(()):
                        settingsUserDefaults.setUserName(username: username)
                        completion(username)
                    case .failure(let error):
                        self.view?.showAlert(with: "getUsernameError", message: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func didLoadView() {
        DispatchQueue.main.async {
            self.interactor.getUserProfileImage { [weak self] result, userProfileImage in
                guard let self = self else {
                    return
                }
                self.handleFetchUserImage(result: result, userProfileImage: userProfileImage)
            }
            
            self.view?.configure(with: ProfileViewModel())
        }
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
