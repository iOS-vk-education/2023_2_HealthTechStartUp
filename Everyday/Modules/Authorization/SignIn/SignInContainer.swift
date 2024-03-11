//
//  SignInContainer.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//  
//

import UIKit

final class SignInContainer {
    let input: SignInModuleInput
    let viewController: UIViewController
    private(set) weak var router: SignInRouterInput!
    
    class func assemble(with context: SignInContext) -> SignInContainer {
        let router = SignInRouter()
        let interactor = SignInInteractor(authService: AuthService.shared)
        let presenter = SignInPresenter(router: router, interactor: interactor)
        let viewController = SignInViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.viewController = viewController
        interactor.output = presenter
        router.viewController = viewController
        
        return SignInContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: SignInModuleInput, router: SignInRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct SignInContext {
    weak var moduleOutput: SignInModuleOutput?
}
