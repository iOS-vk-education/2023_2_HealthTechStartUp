//
//  ChangeEmailProtocols.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

protocol ChangeEmailModuleInput {
    var moduleOutput: ChangeEmailModuleOutput? { get }
}

protocol ChangeEmailModuleOutput: AnyObject {
}

protocol ChangeEmailViewInput: AnyObject {
    func configure(with: ChangeEmailViewModel)
    func showAlert(with key: String, message: String)
}

protocol ChangeEmailViewOutput: AnyObject {
    func didTapConfirmButton(with email: String?, and password: String?)
    func didLoadView()
    func getBack()
    func didTapOnForgotPasswordButton()
}

protocol ChangeEmailInteractorInput: AnyObject {
    func changeEmail(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol ChangeEmailInteractorOutput: AnyObject {
}

protocol ChangeEmailRouterInput: AnyObject {
    func getBackToMainView()
    func getForgotPasswordView()
}
