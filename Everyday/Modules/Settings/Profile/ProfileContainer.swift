//
//  ProfileContainer.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit

final class ProfileContainer {
    let input: ProfileModuleInput
    let viewController: UIViewController
    private(set) weak var router: ProfileRouterInput!
    
    class func assemble(with context: ProfileContext) -> ProfileContainer {
        let router = ProfileRouter()
        let interactor = ProfileInteractor(authService: AuthService.shared)
        let presenter = ProfilePresenter(router: router, interactor: interactor)
        let viewController = ProfileViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return ProfileContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ProfileModuleInput, router: ProfileRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ProfileContext {
    weak var moduleOutput: ProfileModuleOutput?
}
