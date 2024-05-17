//
//  ProfileInteractor.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit

final class ProfileInteractor {
    weak var output: ProfileInteractorOutput?
    private let settingsService: SettingsServiceDescription
    private let authService: AuthServiceDescription
    
    init(settingsService: SettingsServiceDescription, authService: AuthServiceDescription) {
        self.settingsService = settingsService
        self.authService = authService
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func updateUserImage(image: UIImage) {
        settingsService.updateUserImage(image: image) { result in
            self.output?.didUpdateUserImage(result)
        }
    }
    
    func updateUserName(username: String) {
        settingsService.updateUserName(username: username) { result in
            self.output?.didUpdateUserName(username: username, result: result)
        }
    }
    
    func getUserName() {
        settingsService.getUserName { result, username  in
            guard let username = username else {
                self.output?.getUsername(username: nil, result: result)
                return
            }
            self.output?.getUsername(username: username, result: result)
        }
    }
    
    func getUserProfileImage() async {
        do {
            let userProfileImage = try await settingsService.getUserProfileImage()
            self.output?.getUserImage(userImage: userProfileImage, result: .success(()))
        } catch {
            self.output?.getUserImage(userImage: nil, result: .failure(error))
        }
    }

    
    func logout() {
        authService.logout { result in
            self.output?.didLogout(result)
        }
    }
}
