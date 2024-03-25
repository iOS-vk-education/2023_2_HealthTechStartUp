//
//  UnitsContainer.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit

final class UnitsContainer {
    let input: UnitsModuleInput
    let viewController: UIViewController
    private(set) weak var router: UnitsRouterInput!
    
    class func assemble(with context: UnitsContext) -> UnitsContainer {
        let router = UnitsRouter()
        let interactor = UnitsInteractor()
        let presenter = UnitsPresenter(router: router, interactor: interactor)
        let viewController = UnitsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return UnitsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: UnitsModuleInput, router: UnitsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct UnitsContext {
    weak var moduleOutput: UnitsModuleOutput?
}
