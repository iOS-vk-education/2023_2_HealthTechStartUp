//
//  CatalogContainer.swift
//  Everyday
//
//  Created by Михаил on 17.05.2024.
//  
//

import UIKit

final class CatalogContainer {
    let input: CatalogModuleInput
    let viewController: UIViewController
    private(set) weak var router: CatalogRouterInput!
    
    class func assemble(with context: CatalogContext) -> CatalogContainer {
        let router = CatalogRouter()
        let interactor = CatalogInteractor()
        let presenter = CatalogPresenter(router: router, interactor: interactor)
        let viewController = CatalogViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        router.viewController = viewController
        
        return CatalogContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: CatalogModuleInput, router: CatalogRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct CatalogContext {
    weak var moduleOutput: CatalogModuleOutput?
}
