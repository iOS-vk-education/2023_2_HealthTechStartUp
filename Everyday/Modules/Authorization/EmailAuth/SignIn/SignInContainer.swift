//
//  SignInContainer.swift
//  Everyday
//
//  Created by Михаил on 27.04.2024.
//  
//

import UIKit

final class SignInContainer {
    let input: SignInModuleInput
    let viewController: UIViewController
    private(set) weak var router: SignInRouterInput!
    
    static func assemble(with context: SignInContext) -> SignInContainer {
        let router = SignInRouter()
        let interactor = SignInInteractor(authService: AuthService.shared, coreDataService: CoreDataService.shared)
        let presenter = SignInPresenter(router: router, interactor: interactor)
        let viewController = SignInViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput

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
