//
//  ThemeContainer.swift
//  Everyday
//
//  Created by Yaz on 08.03.2024.
//
//

import UIKit

final class ThemeContainer {
    let input: ThemeModuleInput
    let viewController: UIViewController
    private(set) weak var router: ThemeRouterInput!
    
    static func assemble(with context: ThemeContext) -> ThemeContainer {
        let router = ThemeRouter()
        let presenter = ThemePresenter(router: router)
        let viewController = ThemeViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        router.viewController = viewController
        
        return ThemeContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ThemeModuleInput, router: ThemeRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ThemeContext {
    weak var moduleOutput: ThemeModuleOutput?
}
