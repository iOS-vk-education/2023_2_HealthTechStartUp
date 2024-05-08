//
//  AuthorizationRouter.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//  
//

import UIKit

final class AuthorizationRouter {
    weak var viewController: AuthorizationViewController?
}

extension AuthorizationRouter: AuthorizationRouterInput {
    func openOnBoarding(with authType: String) {
        let onBoarding = OnBoardingViewController(authType: authType, onFinish: { [weak self] in
            self?.openApp()
        })
        
        let navigationController = UINavigationController(rootViewController: onBoarding)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true, completion: nil)
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
        
    func openEmailAuth() {
        let emailAuthViewController = SignInContainer.assemble(with: .init()).viewController
        let navController = UINavigationController(rootViewController: emailAuthViewController)
        navController.modalPresentationStyle = .fullScreen

        viewController?.present(navController, animated: true, completion: nil)
    }
}
