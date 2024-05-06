//
//  NotepadContainer.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit

final class NotepadContainer {
    let input: NotepadModuleInput
    let viewController: UIViewController
    private(set) weak var router: NotepadRouterInput!
    
    class func assemble(with context: NotepadContext) -> NotepadContainer {
        let router = NotepadRouter()
        let interactor = NotepadInteractor()
        let presenter = NotepadPresenter(router: router, interactor: interactor)
        let viewController = NotepadViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return NotepadContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: NotepadModuleInput, router: NotepadRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct NotepadContext {
    weak var moduleOutput: NotepadModuleOutput?
}
