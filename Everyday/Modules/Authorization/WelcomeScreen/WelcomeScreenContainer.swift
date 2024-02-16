//
//  WelcomeScreenContainer.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//  
//

import UIKit

final class WelcomeScreenContainer {
    let input: WelcomeScreenModuleInput
    let viewController: UIViewController
    private(set) weak var router: WelcomeScreenRouterInput!
    
    class func assemble(with context: WelcomeScreenContext) -> WelcomeScreenContainer {
        let signInViewController = SignInContainer.assemble(with: .init()).viewController
        let signUpViewController = SignUpContainer.assemble(with: .init()).viewController
        let router = WelcomeScreenRouter(signInViewController: signInViewController, signUpViewController: signUpViewController)
        
        let presenter = WelcomeScreenPresenter(router: router)
        let viewController = WelcomeScreenViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        router.viewController = viewController
        
        return WelcomeScreenContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: WelcomeScreenModuleInput, router: WelcomeScreenRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct WelcomeScreenContext {
    weak var moduleOutput: WelcomeScreenModuleOutput?
}
