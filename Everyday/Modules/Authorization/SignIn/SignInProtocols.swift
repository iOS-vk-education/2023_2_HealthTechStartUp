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
    func showAlert(with key: String, message: NSMutableAttributedString)
}

protocol SignInViewOutput: AnyObject {
    func didLoadView()
    func didTapSignInButton(with email: String?, and password: String?)
    func didTapSignWithGoogleButton()
    func didTapSignSignWithVKButton()
    func didTapSignSignWithAnonymButton()
}

protocol SignInInteractorInput: AnyObject {
    func loginWithEmail(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func loginWithGoogle(with flag: Bool, completion: @escaping (Result<Void, Error>) -> Void)
}

protocol SignInInteractorOutput: AnyObject {
}

protocol SignInRouterInput: AnyObject {
    func openApp()
    func openOnBoarding()
}
