//
//  SheetContainer.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//  
//

import UIKit

final class SheetContainer {
    let input: SheetModuleInput
    let viewController: UIViewController
    private(set) weak var router: SheetRouterInput!
    
    class func assemble(with context: SheetContext) -> SheetContainer {
        let router = SheetRouter()
        let interactor = SheetInteractor()
        let presenter = SheetPresenter(router: router, interactor: interactor, moduleType: context.type)
        let viewController = SheetViewController(output: presenter, type: context.type)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return SheetContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: SheetModuleInput, router: SheetRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct SheetContext {
    weak var moduleOutput: SheetModuleOutput?
    let type: SheetType
}
