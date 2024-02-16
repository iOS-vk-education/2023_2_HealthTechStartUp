//
//  SignUpRouter.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//  
//

import UIKit

final class SignUpRouter {
    weak var viewController: SignUpViewController?
}

extension SignUpRouter: SignUpRouterInput {
    func openOnBoarding() {
        let onBoarding = onBoardingViewController(onFinish: { [weak self] in
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
}
