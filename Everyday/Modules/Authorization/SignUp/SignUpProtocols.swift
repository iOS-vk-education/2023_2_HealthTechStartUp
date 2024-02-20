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
}

protocol SignUpViewOutput: AnyObject {
    func didLoadView()
    func didTapSignUpButton()
    func didTapSignWithVKButton()
    func didTapSignWithGoogleButton()
}

protocol SignUpInteractorInput: AnyObject {
    func authWithVKID()
    func authWithGoogle()
}

protocol SignUpInteractorOutput: AnyObject {
}

protocol SignUpRouterInput: AnyObject {
    func openOnBoarding()
}
