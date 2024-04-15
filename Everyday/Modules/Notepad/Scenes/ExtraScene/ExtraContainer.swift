//
//  ExtraContainer.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class ExtraContainer {
    let input: ExtraModuleInput
    let viewController: UIViewController
    private(set) weak var router: ExtraRouterInput!
    
    class func assemble(with context: ExtraContext) -> ExtraContainer {
        let router = ExtraRouter()
        let interactor = ExtraInteractor()
        let presenter = ExtraPresenter(router: router, interactor: interactor)
        let viewController = ExtraViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.presenter = presenter
        router.viewController = viewController
        
        return ExtraContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ExtraModuleInput, router: ExtraRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ExtraContext {
    weak var moduleOutput: ExtraModuleOutput?
}
