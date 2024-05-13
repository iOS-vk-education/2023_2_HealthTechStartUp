//
//  WorkoutContainer.swift
//  workout
//
//  Created by Михаил on 21.03.2024.
//  
//

import UIKit

final class WorkoutContainer {
    let input: WorkoutModuleInput
    let viewController: UIViewController
    private(set) weak var router: WorkoutRouterInput!
    
    class func assemble(with context: WorkoutContext) -> WorkoutContainer {
        let programsViewController = ProgramsContainer.assemble(with: .init()).viewController
        let walkProgramsViewController = WalkProgramsContainer.assemble(with: .init()).viewController
        let router = WorkoutRouter(programsViewController: programsViewController, walkProgramsViewController: walkProgramsViewController)
        
        let interactor = WorkoutInteractor()
        let presenter = WorkoutPresenter(router: router, interactor: interactor)
        let viewController = WorkoutViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        router.viewController = viewController
        
        return WorkoutContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: WorkoutModuleInput, router: WorkoutRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct WorkoutContext {
    weak var moduleOutput: WorkoutModuleOutput?
}
