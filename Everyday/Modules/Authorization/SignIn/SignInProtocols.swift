//
//  SignInProtocols.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
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
    func showAlert(with key: String, message: String)
}

protocol SignInViewOutput: AnyObject {
    func didLoadView()
    func didTapSignInButton(with email: String?, and password: String?)
    func didTapSignInWithGoogleButton()
    func didTapSignInWithVKButton()
    func didTapSignInWithAppleButton()
}

protocol SignInInteractorInput: AnyObject {
    func loginWithEmail(with flag: Bool, email: String, password: String)
    func loginWithVK(with flag: Bool)
    func loginWithGoogle(with flag: Bool)
    func isAuthExist(for service: String) -> Bool
}

protocol SignInInteractorOutput: AnyObject {
    func authExistResult(isExists: Bool) -> Bool
    func authResult(signedUp: Bool, service: String, _ result: Result<Void, Error>)
}

protocol SignInRouterInput: AnyObject {
    func openApp()
    func openOnBoarding(with authType: String)
}
