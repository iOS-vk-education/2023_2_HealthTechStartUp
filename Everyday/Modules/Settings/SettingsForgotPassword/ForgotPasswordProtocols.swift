//
//  ForgotPasswordProtocols.swift
//  Everyday
//
//  Created by Yaz on 14.04.2024.
//

import Foundation

protocol ForgotPasswordModuleInput {
    var moduleOutput: ForgotPasswordModuleOutput? { get }
}

protocol ForgotPasswordModuleOutput: AnyObject {
}

protocol ForgotPasswordViewInput: AnyObject {
    func configure(with: SettingsForgotPasswordViewModel)
    func showAlert(with key: String, message: String)
}

protocol ForgotPasswordViewOutput: AnyObject {
    func didTapConfirmButton(with email: String?)
    func didSwipe()
    func getBack()
    func didLoadView()
}

protocol ForgotPasswordInteractorInput: AnyObject {
    func sendForgotPasswordMessage(with email: String, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol ForgotPasswordInteractorOutput: AnyObject {
}

protocol ForgotPasswordRouterInput: AnyObject {
    func getBackToMainView()
}
