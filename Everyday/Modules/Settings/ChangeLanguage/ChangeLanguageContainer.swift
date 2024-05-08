//
//  ChangeLanguageContainer.swift
//  Everyday
//
//  Created by Yaz on 05.05.2024.
//  
//

import UIKit

final class ChangeLanguageContainer {
    let input: ChangeLanguageModuleInput
    let viewController: UIViewController
    private(set) weak var router: ChangeLanguageRouterInput!
    
    class func assemble(with context: ChangeLanguageContext) -> ChangeLanguageContainer {
        let router = ChangeLanguageRouter()
        let presenter = ChangeLanguagePresenter(router: router)
        let viewController = ChangeLanguageViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        router.viewController = viewController
        
        return ChangeLanguageContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ChangeLanguageModuleInput, router: ChangeLanguageRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ChangeLanguageContext {
    weak var moduleOutput: ChangeLanguageModuleOutput?
}
