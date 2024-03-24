//
//  ProfileProtocols.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation

protocol ProfileModuleInput {
    var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: AnyObject {
}

protocol ProfileViewInput: AnyObject {
    func configure(with: ProfileViewModel)
    func showAlert()
}

protocol ProfileViewOutput: AnyObject {
    func didLoadView()
    func didTapLogoutButton()
    func didTapChangeEmailCell()
    func didTapChangePasswordCell()
    func didTapDeleteAccountCell()
    func getBack()
}

protocol ProfileInteractorInput: AnyObject {
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
