//
//  ChangePasswordContainer.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class ChangePasswordContainer {
    let input: ChangePasswordModuleInput
    let viewController: UIViewController
    private(set) weak var router: ChangePasswordRouterInput!
    
    class func assemble(with context: ChangePasswordContext) -> ChangePasswordContainer {
        let router = ChangePasswordRouter()
        let interactor = ChangePasswordInteractor(authService: AuthService.shared)
        let presenter = ChangePasswordPresenter(router: router, interactor: interactor)
        let viewController = ChangePasswordViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return ChangePasswordContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ChangePasswordModuleInput, router: ChangePasswordRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ChangePasswordContext {
    weak var moduleOutput: ChangePasswordModuleOutput?
}
