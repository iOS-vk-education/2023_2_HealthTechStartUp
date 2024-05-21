//
//  DateAndTimeContainer.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit

final class DateAndTimeContainer {
    let input: DateAndTimeModuleInput
    let viewController: UIViewController
    private(set) weak var router: DateAndTimeRouterInput!
    
    static func assemble(with context: DateAndTimeContext) -> DateAndTimeContainer {
        let router = DateAndTimeRouter()
        let presenter = DateAndTimePresenter(router: router)
        let viewController = DateAndTimeViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        router.viewController = viewController
        
        return DateAndTimeContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: DateAndTimeModuleInput, router: DateAndTimeRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct DateAndTimeContext {
    weak var moduleOutput: DateAndTimeModuleOutput?
}
