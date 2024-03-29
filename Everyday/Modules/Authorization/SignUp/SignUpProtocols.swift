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
    func showAlert(with key: String, message: String)
}

protocol SignUpViewOutput: AnyObject {
    func didLoadView()
    func didTapSignUpButton(with email: String?, and password: String?)
    func didTapSignWithVKButton()
    func didTapSignWithGoogleButton()
    func didTapSignWithAnonymButton()
}

protocol SignUpInteractorInput: AnyObject {
    func authWithGoogle()
    func authWithVKID()
    func isAuthExist(for service: String) -> Bool
}

protocol SignUpInteractorOutput: AnyObject {
    func authExistResult(isExists: Bool) -> Bool
    func authResult(service: String, _ result: Result<Void, Error>) 
}

protocol SignUpRouterInput: AnyObject {
    func openOnBoarding(with authType: String)
}
