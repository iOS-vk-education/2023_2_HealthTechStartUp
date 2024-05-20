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
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            fatalError("oops")
        }

        let tabBarController = TabBarController()

        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = tabBarController
        }, completion: nil)
    }
        
    func openEmailAuth() {
        let emailAuthViewController = SignInContainer.assemble(with: .init()).viewController
        let navController = UINavigationController(rootViewController: emailAuthViewController)
        navController.modalPresentationStyle = .fullScreen

        viewController?.present(navController, animated: true, completion: nil)
    }
}
