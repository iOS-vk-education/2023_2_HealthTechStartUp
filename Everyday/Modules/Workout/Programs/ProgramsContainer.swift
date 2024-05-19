//
//  ProgramsContainer.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//  
//

import UIKit

final class ProgramsContainer {
    let input: ProgramsModuleInput
    let viewController: UIViewController
    private(set) weak var router: ProgramsRouterInput!
    
    class func assemble(with context: ProgramsContext) -> ProgramsContainer {
        let router = ProgramsRouter()
        let interactor = ProgramsInteractor(catalogService: CatalogService.shared)
        let presenter = ProgramsPresenter(router: router, interactor: interactor)
        let viewController = ProgramsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        router.viewController = viewController
        
        return ProgramsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ProgramsModuleInput, router: ProgramsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ProgramsContext {
    weak var moduleOutput: ProgramsModuleOutput?
}
