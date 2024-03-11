//
//  SignInRouter.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
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
           let appViewController = TabBarController()
            appViewController.modalPresentationStyle = .fullScreen

            UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                window.rootViewController = appViewController
            }, completion: nil)
        }
    }
    
    func openOnBoarding() {
        let onBoarding = OnBoardingViewController(onFinish: { [weak self] in
            self?.openApp()
        })
        
        let navigationController = UINavigationController(rootViewController: onBoarding)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true, completion: nil)
    }
}
