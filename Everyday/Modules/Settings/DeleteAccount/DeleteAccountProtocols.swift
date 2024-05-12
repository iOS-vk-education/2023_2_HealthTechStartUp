//
//  DeleteAccountProtocols.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

protocol DeleteAccountModuleInput {
    var moduleOutput: DeleteAccountModuleOutput? { get }
}

protocol DeleteAccountModuleOutput: AnyObject {
}

protocol DeleteAccountViewInput: AnyObject {
    func showAlert(with type: AlertType)
    func configure(with: DeleteAccountViewModel)
}

protocol DeleteAccountViewOutput: AnyObject {
    func getWhichSign() -> String
    func didTapConfirmButton(with email: String?, and password: String?)
    func didLoadView()
    func getBack()
    func didTapOnForgotPasswordButton()
}

protocol DeleteAccountInteractorInput: AnyObject {
    func deleteAccount(email: String, password: String)
}

protocol DeleteAccountInteractorOutput: AnyObject {
    func didDelete(_ result: Result<Void, Error>, _ reauth: Bool?)
}

protocol DeleteAccountRouterInput: AnyObject {
    func routeToAuthentication()
    func getBackToMainView()
    func getForgotPasswordView()
}
