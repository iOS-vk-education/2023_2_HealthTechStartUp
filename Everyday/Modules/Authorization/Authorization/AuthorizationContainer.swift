//
//  AuthorizationContainer.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//  
//

import UIKit

final class AuthorizationContainer {
    let input: AuthorizationModuleInput
    let viewController: UIViewController
    private(set) weak var router: AuthorizationRouterInput!
    
    class func assemble(with context: AuthorizationContext) -> AuthorizationContainer {
        let router = AuthorizationRouter()
        let interactor = AuthorizationInteractor(authService: AuthService.shared, coreDataService: CoreDataService.shared)
        let presenter = AuthorizationPresenter(router: router, interactor: interactor)
        let viewController = AuthorizationViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        interactor.viewController = viewController
        router.viewController = viewController
        
        return AuthorizationContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: AuthorizationModuleInput, router: AuthorizationRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct AuthorizationContext {
    weak var moduleOutput: AuthorizationModuleOutput?
}
