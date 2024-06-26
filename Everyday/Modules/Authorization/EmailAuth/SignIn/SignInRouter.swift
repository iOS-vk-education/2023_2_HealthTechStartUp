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
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }

        let tabBarController = TabBarController()

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = tabBarController
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
