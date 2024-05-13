//
//  WalkProgramsContainer.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//  
//

import UIKit

final class WalkProgramsContainer {
    let input: WalkProgramsModuleInput
    let viewController: UIViewController
    private(set) weak var router: WalkProgramsRouterInput!
    
    class func assemble(with context: WalkProgramsContext) -> WalkProgramsContainer {
        let router = WalkProgramsRouter()
        let interactor = WalkProgramsInteractor()
        let presenter = WalkProgramsPresenter(router: router, interactor: interactor)
        let viewController = WalkProgramsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return WalkProgramsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: WalkProgramsModuleInput, router: WalkProgramsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct WalkProgramsContext {
    weak var moduleOutput: WalkProgramsModuleOutput?
}
