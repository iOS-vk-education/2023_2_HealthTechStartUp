//
//  ChangePasswordProtocols.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

protocol ChangePasswordModuleInput {
    var moduleOutput: ChangePasswordModuleOutput? { get }
}

protocol ChangePasswordModuleOutput: AnyObject {
}

protocol ChangePasswordViewInput: AnyObject {
    func showAlert(with type: AlertType)
    func configure(with: ChangePasswordViewModel)
}

protocol ChangePasswordViewOutput: AnyObject {
    func didTapConfirmButton(with oldPassword: String?, and newPassword: String?)
    func didLoadView()
    func getBack()
    func didTapOnForgotPasswordButton()
}

protocol ChangePasswordInteractorInput: AnyObject {
    func changePassword(oldPassword: String, newPassword: String)
}

protocol ChangePasswordInteractorOutput: AnyObject {
    func didChanged(_ result: Result<Void, Error>, _ reauth: Bool?)
}

protocol ChangePasswordRouterInput: AnyObject {
    func getBackToMainView()
    func getForgotPasswordView()
}
