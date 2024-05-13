//
//  SignUpProtocols.swift
//  Everyday
//
//  Created by Михаил on 28.04.2024.
//  
//

import Foundation

protocol SignUpModuleInput {
    var moduleOutput: SignUpModuleOutput? { get }
}

protocol SignUpModuleOutput: AnyObject {
}

protocol SignUpViewInput: AnyObject {
    func configure(with model: SignUpViewModel)
    func showAlert(with type: AlertType)
}

protocol SignUpViewOutput: AnyObject {
    func didLoadView()
    func didTapCloseButton()
    func didTapSignupButton(with email: String, and password: String)
    func didTapLoginButton()
}

protocol SignUpInteractorInput: AnyObject {
    func checkUserExist(with email: String)
}

protocol SignUpInteractorOutput: AnyObject {
    func didUserExist(_ result: Result<Void, Error>)
}

protocol SignUpRouterInput: AnyObject {
    func closeView()
    func openLogin()
    func openOnBoarding(with authType: String)
    func openApp()
}
