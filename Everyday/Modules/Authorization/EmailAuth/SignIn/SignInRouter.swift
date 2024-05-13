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
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
            let tabBarController = TabBarController()
            let navigationController = UINavigationController(rootViewController: tabBarController)
            navigationController.modalPresentationStyle = .fullScreen

            UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve], animations: {
                window.rootViewController = navigationController
            }, completion: nil)
        }
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
