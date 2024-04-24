//
//  ResultsContainer.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class ResultsContainer {
    let input: ResultsModuleInput
    let viewController: UIViewController
    private(set) weak var router: ResultsRouterInput!
    
    class func assemble(with context: ResultsContext) -> ResultsContainer {
        let router = ResultsRouter()
        let interactor = ResultsInteractor()
        let presenter = ResultsPresenter(router: router, interactor: interactor, exercises: context.exercises)
        let viewController = ResultsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return ResultsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ResultsModuleInput, router: ResultsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ResultsContext {
    weak var moduleOutput: ResultsModuleOutput?
    var exercises: [NewExercise]
}
