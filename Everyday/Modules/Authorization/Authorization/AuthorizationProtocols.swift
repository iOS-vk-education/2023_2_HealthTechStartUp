//
//  AuthorizationProtocols.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//  
//

import Foundation

protocol AuthorizationModuleInput {
    var moduleOutput: AuthorizationModuleOutput? { get }
}

protocol AuthorizationModuleOutput: AnyObject {
}

protocol AuthorizationViewInput: AnyObject {
    func configure(with model: AuthorizationViewModel)
    func showAlert(with type: AlertType)
}

protocol AuthorizationViewOutput: AnyObject {
    func didLoadView()
    func didTapSignInWithEmailButton()
    func didTapSignInWithGoogleButton()
    func didTapSignInWithVKButton()
    func didTapSignInWithAppleButton()
}

protocol AuthorizationInteractorInput: AnyObject {
    func authWithVK(with flag: Bool)
    func authWithGoogle(with flag: Bool)
    func isAuthExist(for service: String) -> Bool
}

protocol AuthorizationInteractorOutput: AnyObject {
    func didAuthExist(isExists: Bool) -> Bool
    func didAuth(signedUp: Bool, service: String, _ result: Result<Void, Error>)
}

protocol AuthorizationRouterInput: AnyObject {
    func openApp()
    func openOnBoarding(with authType: String)
    func openEmailAuth()
}
