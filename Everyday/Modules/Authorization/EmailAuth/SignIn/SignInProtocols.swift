//
//  SignInProtocols.swift
//  Everyday
//
//  Created by Михаил on 27.04.2024.
//  
//

import Foundation

protocol SignInModuleInput {
    var moduleOutput: SignInModuleOutput? { get }
}

protocol SignInModuleOutput: AnyObject {
}

protocol SignInViewInput: AnyObject {
    func configure(with model: SignInViewModel)
    func showAlert(with type: AlertType)
}

protocol SignInViewOutput: AnyObject {
    func didLoadView()
    func didTapLoginButton(with email: String, and password: String)
    func didTapSignupButton()
    func didTapForgotPasswordButton()
    func didTapCloseButton()
}

protocol SignInInteractorInput: AnyObject {
    func authWithEmail(model: Email)
    func isAuthExist(for service: String) -> Bool
    func checkUserExist(with model: Email)
}

protocol SignInInteractorOutput: AnyObject {
    func didAuth(_ result: Result<Void, Error>)
    func didAuthExist(isExists: Bool) -> Bool
    func didUserExist(_ model: Email, _ result: Result<Void, Error>)
}

protocol SignInRouterInput: AnyObject {
    func openApp()
    func openSignup()
    func openForgot()
    func closeView()
}
