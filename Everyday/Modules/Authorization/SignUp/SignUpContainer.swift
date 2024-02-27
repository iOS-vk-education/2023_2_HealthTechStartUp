//
//  SignUpContainer.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//
//

import UIKit

final class SignUpContainer {
    let input: SignUpModuleInput
    let viewController: UIViewController
    private(set) weak var router: SignUpRouterInput!
    
    class func assemble(with context: SignUpContext) -> SignUpContainer {
        let router = SignUpRouter()
        let interactor = SignUpInteractor(authService: AuthService.shared)
        let presenter = SignUpPresenter(router: router, interactor: interactor)
        let viewController = SignUpViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.viewController = viewController
        interactor.output = presenter
        router.viewController = viewController
        
        return SignUpContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: SignUpModuleInput, router: SignUpRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct SignUpContext {
    weak var moduleOutput: SignUpModuleOutput?
}
