//
//  TimerContainer.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//
//

import UIKit

final class TimerContainer {
    let input: TimerModuleInput
    let viewController: UIViewController
    private(set) weak var router: TimerRouterInput!
    
    class func assemble(with context: TimerContext) -> TimerContainer {
        let router = TimerRouter()
        let interactor = TimerInteractor()
        let presenter = TimerPresenter(router: router, interactor: interactor)
        let viewController = TimerViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return TimerContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: TimerModuleInput, router: TimerRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct TimerContext {
    weak var moduleOutput: TimerModuleOutput?
}
