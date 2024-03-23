//
//  SettingsContainer.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit

final class SettingsContainer {
    let input: SettingsModuleInput
    let viewController: UIViewController
    private(set) weak var router: SettingsRouterInput!
    
    class func assemble(with context: SettingsContext) -> SettingsContainer {
        let router = SettingsRouter()
        let interactor = SettingsInteractor(authService: AuthService.shared)
        let presenter = SettingsPresenter(router: router, interactor: interactor)
        let viewController = SettingsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        router.viewController = viewController
        
        return SettingsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: SettingsModuleInput, router: SettingsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct SettingsContext {
    weak var moduleOutput: SettingsModuleOutput?
}
