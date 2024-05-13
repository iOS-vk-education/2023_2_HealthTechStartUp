//
//  TrainingContainer.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//
//

import UIKit

final class TrainingContainer {
    let input: TrainingModuleInput
    let viewController: UIViewController
    private(set) weak var router: TrainingRouterInput!
    
    class func assemble(with context: TrainingContext) -> TrainingContainer {
        let router = TrainingRouter()
        let interactor = TrainingInteractor()
        let presenter = TrainingPresenter(router: router, interactor: interactor, workoutDay: context.workoutDay)
        let viewController = TrainingViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return TrainingContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: TrainingModuleInput, router: TrainingRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct TrainingContext {
    weak var moduleOutput: TrainingModuleOutput?
    let workoutDay: WorkoutDay
}
