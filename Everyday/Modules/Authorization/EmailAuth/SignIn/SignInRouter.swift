//
//  SignInRouter.swift
//  Everyday
//
//  Created by Михаил on 27.04.2024.
//
//

import UIKit

final class SignInRouter {
    weak var viewController: SignInViewController?
}

extension SignInRouter: SignInRouterInput {
    func openApp() {
        guard let navigationController = viewController?.navigationController else {
            fatalError("SignInViewController is not embedded in a navigation controller.")
        }

       let tabBarController = TabBarController()
       tabBarController.modalPresentationStyle = .fullScreen

        UIView.transition(with: navigationController.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            navigationController.setViewControllers([tabBarController], animated: false)
        }, completion: nil)
    }

    func openSignup() {
        let signUpViewController = SignUpContainer.assemble(with: .init()).viewController
        viewController?.navigationController?.pushViewController(signUpViewController, animated: true)
    }

    func openForgot() {
        viewController?.navigationController?.pushViewController(ForgotPasswordViewController(authService: AuthService.shared), animated: true)
    }

    func closeView() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
