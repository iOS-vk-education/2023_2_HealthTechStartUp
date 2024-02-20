//
//  WelcomeScreenRouter.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//
//

import UIKit

final class WelcomeScreenRouter {
    weak var viewController: WelcomeScreenViewController?
    private let signInViewController: UIViewController
    private let signUpViewController: UIViewController
    
    init(signInViewController: UIViewController, signUpViewController: UIViewController) {
        self.signInViewController = SignInContainer.assemble(with: .init()).viewController
        self.signUpViewController = SignUpContainer.assemble(with: .init()).viewController
    }
}

extension WelcomeScreenRouter: WelcomeScreenRouterInput {
    
    func getSignInView() -> UIViewController {
        return signInViewController
    }
    
    func getSignUpView() -> UIViewController {
        return signUpViewController
    }
}
