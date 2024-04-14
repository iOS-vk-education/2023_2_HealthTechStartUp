//
//  ExerciseContainer.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class ExerciseContainer {
    let input: ExerciseModuleInput
    let viewController: UIViewController
    private(set) weak var router: ExerciseRouterInput!
    
    class func assemble(with context: ExerciseContext) -> ExerciseContainer {
        let router = ExerciseRouter()
        let interactor = ExerciseInteractor()
        let presenter = ExercisePresenter(router: router, interactor: interactor, exercise: context.exercise, indexOfSet: context.indexOfSet)
        let viewController = ExerciseViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return ExerciseContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: ExerciseModuleInput, router: ExerciseRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct ExerciseContext {
    weak var moduleOutput: ExerciseModuleOutput?
    let exercise: Exercise
    let indexOfSet: Int
}
