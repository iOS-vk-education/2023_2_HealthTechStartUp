//
//  ProgressContainer.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit

final class ProgressContainer {
    let input: ProgressModuleInput
    let viewController: UIViewController
    private(set) weak var router: ProgressRouterInput!
    
    class func assemble(with context: ProgressContext) -> ProgressContainer {
        let router = ProgressRouter()
        let interactor = ProgressInteractor()
        let presenter = ProgressPresenter(router: router, interactor: interactor)
        let viewController = ProgressViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return ProgressContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ProgressModuleInput, router: ProgressRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ProgressContext {
    weak var moduleOutput: ProgressModuleOutput?
}
