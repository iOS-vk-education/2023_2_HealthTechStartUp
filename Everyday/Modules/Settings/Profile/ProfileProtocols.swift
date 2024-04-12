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
    func showAlert(with key: String, message: String)
    func setupProfileImage(image: UIImage)
}

protocol ProfileViewOutput: AnyObject {
    func getWhichSing() -> String
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
    func updateUserImage(image: UIImage, completion: @escaping (Result<Void, Error>) -> Void)
    func updateUserName(username: String, completion: @escaping (Result<Void, Error>) -> Void)
    func getUserProfileImage(completion: @escaping (Result<Void, Error>, UIImage) -> Void)
    func getUserName(completion: @escaping (Result<Void, Error>, String) -> Void)
    func logout(completion: @escaping (Result<Void, Error>) -> Void)
}

protocol ProfileInteractorOutput: AnyObject {
}

protocol ProfileRouterInput: AnyObject {
    func routeToAuthentication()
    func getChangeEmailView()
    func getChangePasswordView()
    func getDeleteAccountView()
    func getBackToMainView()
}
