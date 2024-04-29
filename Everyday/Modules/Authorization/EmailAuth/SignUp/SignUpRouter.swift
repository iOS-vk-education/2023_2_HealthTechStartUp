//
//  SignUpRouter.swift
//  Everyday
//
//  Created by Михаил on 28.04.2024.
//  
//

import UIKit

final class SignUpRouter {
    weak var viewController: SignUpViewController?
}

extension SignUpRouter: SignUpRouterInput {
    func closeView() {
        viewController?.dismiss(animated: true, completion: nil)
    }
        
    func openApp() {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
           let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
           let appViewController = TabBarController()
            appViewController.modalPresentationStyle = .fullScreen

            UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                window.rootViewController = appViewController
            }, completion: nil)
        }
    }
    
    func openLogin() {
        let signInViewController = SignInContainer.assemble(with: .init()).viewController
        // signInViewController.modalTransitionStyle = .crossDissolve
        viewController?.navigationController?.pushViewController(signInViewController, animated: true)
    }
    
    func openOnBoarding(with authType: String) {
        let onBoarding = OnBoardingViewController(authType: authType, onFinish: { [weak self] in
            self?.openApp()
        })
        
        let navigationController = UINavigationController(rootViewController: onBoarding)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true, completion: nil)
    }
}
