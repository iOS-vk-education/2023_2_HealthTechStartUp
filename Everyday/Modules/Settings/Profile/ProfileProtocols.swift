//
//  ProfileProtocols.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation
import UIKit

protocol ProfileModuleInput {
    var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: AnyObject {
}

protocol ProfileViewInput: AnyObject {
    func configure(with: ProfileViewModel)
    func showAlert(with type: AlertType)
    func setupProfileImage(image: UIImage)
    func reloadData()
}

protocol ProfileViewOutput: AnyObject {
    func getWhichSign() -> String
    func getProfileViewModelSingWithEmail() -> ProfileViewModelSingWithEmail
    func getProfileViewModelSingWithVKOrGoogle() -> ProfileViewModelSingWithVKOrGoogle
    func updateUserName(username: String)
    func getUsername(completion: @escaping (String?) -> Void)
    func didTapChangeUserImageButton(image: UIImage?, error: Error?)
    func didLoadView()
    func didTapLogoutButton()
    func didTapChangeEmailCell()
    func didTapChangePasswordCell()
    func didTapDeleteAccountCell()
    func didSwipe()
}

protocol ProfileInteractorInput: AnyObject {
    func updateUserImage(image: UIImage)
    func updateUserName(username: String)
    func getUserProfileImage()
    func getUserName()
    func logout()
}

protocol ProfileInteractorOutput: AnyObject {
    func didUpdateUserImage(_ result: Result<Void, Error>)
    func didUpdateUserName(username: String, result: Result<Void, Error>)
    func getUsername(username: String?, result: Result<Void, Error>)
    func getUserImage(userImage: UIImage?, result: Result<Void, Error>)
    func didLogout(_ result: Result<Void, Error>)
}

protocol ProfileRouterInput: AnyObject {
    func getChangeEmailView()
    func getChangePasswordView()
    func getDeleteAccountView()
    func getBackToMainView()
}
