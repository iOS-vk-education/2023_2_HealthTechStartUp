//
//  ChangeEmailContainer.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class ChangeEmailContainer {
    let input: ChangeEmailModuleInput
    let viewController: UIViewController
    private(set) weak var router: ChangeEmailRouterInput!
    
    class func assemble(with context: ChangeEmailContext) -> ChangeEmailContainer {
        let router = ChangeEmailRouter()
        let interactor = ChangeEmailInteractor(authService: AuthService.shared)
        let presenter = ChangeEmailPresenter(router: router, interactor: interactor)
        let viewController = ChangeEmailViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return ChangeEmailContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ChangeEmailModuleInput, router: ChangeEmailRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ChangeEmailContext {
    weak var moduleOutput: ChangeEmailModuleOutput?
}
