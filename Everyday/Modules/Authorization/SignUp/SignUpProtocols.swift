//
//  SignUpProtocols.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
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
    func showAlert(with key: String, message: NSMutableAttributedString)
}

protocol SignUpViewOutput: AnyObject {
    func didLoadView()
    func didTapSignUpButton(with email: String?, and password: String?)
    func didTapSignWithVKButton()
    func didTapSignWithGoogleButton()
}

protocol SignUpInteractorInput: AnyObject {
    func authWithGoogle(completion: @escaping () -> Void)
    func authWithVKID(completion: @escaping () -> Void)
}

protocol SignUpInteractorOutput: AnyObject {
}

protocol SignUpRouterInput: AnyObject {
    func openOnBoarding()
}
