//
//  DeleteAccountContainer.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class DeleteAccountContainer {
    let input: DeleteAccountModuleInput
    let viewController: UIViewController
    private(set) weak var router: DeleteAccountRouterInput!
    
    class func assemble(with context: DeleteAccountContext) -> DeleteAccountContainer {
        let router = DeleteAccountRouter()
        let interactor = DeleteAccountInteractor()
        let presenter = DeleteAccountPresenter(router: router, interactor: interactor)
        let viewController = DeleteAccountViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return DeleteAccountContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: DeleteAccountModuleInput, router: DeleteAccountRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct DeleteAccountContext {
    weak var moduleOutput: DeleteAccountModuleOutput?
}
