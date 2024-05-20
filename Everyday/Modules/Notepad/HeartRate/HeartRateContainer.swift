//
//  HeartRateContainer.swift
//  Everyday
//
//  Created by Михаил on 12.05.2024.
//
//

import UIKit

final class HeartRateContainer {
    let input: HeartRateModuleInput
    let viewController: UIViewController
    private(set) weak var router: HeartRateRouterInput!
    
    static func assemble(with context: HeartRateContext) -> HeartRateContainer {
        let router = HeartRateRouter()
        let interactor = HeartRateInteractor()
        let presenter = HeartRatePresenter(router: router, interactor: interactor)
        let viewController = HeartRateViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return HeartRateContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: HeartRateModuleInput, router: HeartRateRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct HeartRateContext {
    weak var moduleOutput: HeartRateModuleOutput?
}
