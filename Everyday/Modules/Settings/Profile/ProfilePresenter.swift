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
    
    private let settingsUserDefaults = SettingsUserDefaultsService.shared
    
    init(router: ProfileRouterInput, interactor: ProfileInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    private func handleUpdateImageError(_ error: Error?) {
        guard let error = error else {
            return
        }
        
        self.view?.showAlert(with: .fetchingUserError(error: error as NSError))
    }
    
    private func handleFetchUserImage(result: Result<Void, Error>, userProfileImage: UIImage) {
        switch result {
        case .success:
            self.view?.setupProfileImage(image: userProfileImage)
        case .failure(let error):
            self.view?.showAlert(with: .fetchingUserError(error: error))
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
            
            self.interactor.updateUserImage(image: image)
        }
    }
    
    func updateUserName(username: String) {
        DispatchQueue.main.async {
            self.interactor.updateUserName(username: username)
        }
    }
    
    func didTapLogoutButton() {
        interactor.logout()
    }
    
    func getUsername(completion: @escaping (String?) -> Void) {
        DispatchQueue.main.async {
            let settingsUserDefaults = SettingsUserDefaultsService.shared
            let currentUserName = settingsUserDefaults.getUserName()
            completion(currentUserName)
            
            self.interactor.getUserName()
        }
    }
    
    func didLoadView() {
        Task {
            await interactor.getUserProfileImage()
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

    func didUpdateUserImage(_ result: Result<Void, any Error>) {
        switch result {
        case .success: print("Success update image")
        case .failure(let error):
            self.handleUpdateImageError(error)
        }
    }
    
    func didUpdateUserName(username: String, result: Result<Void, any Error>) {
        switch result {
        case .success:
            SettingsUserDefaultsService.shared.setUserName(username: username)
        case .failure(let error):
            self.view?.showAlert(with: .networkMessage(error: error))
        }
    }
    
    func getUsername(username: String?, result: Result<Void, any Error>) {
        let settingsUserDefaults = SettingsUserDefaultsService.shared
        let currentUserName = settingsUserDefaults.getUserName()
        
        if username != currentUserName {
            switch result {
            case .success(()):
                self.settingsUserDefaults.setUserName(username: username ?? "")
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showAlert(with: .fetchingUserError(error: error))
            }
        }
    }
    
    func getUserImage(userImage: UIImage?, result: Result<Void, any Error>) {
        DispatchQueue.main.async {
            self.handleFetchUserImage(result: result, userProfileImage: userImage ?? UIImage())
            self.view?.configure(with: ProfileViewModel())
        }
    }
    
    func didLogout(_ result: Result<Void, any Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                SettingsUserDefaultsService.shared.setAutoTheme()
                SettingsUserDefaultsService.shared.resetUserDefaults()
                Reloader.shared.setLogout()
                self.router.getBackToMainView()
            case .failure(let error):
                self.view?.showAlert(with: .logoutError(error: error))
            }
        }
    }
}
