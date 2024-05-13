//
//  HealthContainer.swift
//  Everyday
//
//  Created by Yaz on 16.04.2024.
//  
//

import UIKit

final class HealthContainer {
    let input: HealthModuleInput
    let viewController: UIViewController
    private(set) weak var router: HealthRouterInput!
    
    class func assemble(with context: HealthContext) -> HealthContainer {
        let router = HealthRouter()
        let interactor = HealthInteractor()
        let presenter = HealthPresenter(router: router, interactor: interactor)
        let viewController = HealthViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        router.viewController = viewController
        
        return HealthContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: HealthModuleInput, router: HealthRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct HealthContext {
    weak var moduleOutput: HealthModuleOutput?
}
