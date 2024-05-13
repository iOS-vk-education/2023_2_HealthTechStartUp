//
//  WorkoutRouter.swift
//  workout
//
//  Created by Михаил on 21.03.2024.
//  
//

import UIKit

final class WorkoutRouter {
    weak var viewController: WorkoutViewController?
    private let programsViewController: UIViewController
    private let walkProgramsViewController: UIViewController
    
    init(programsViewController: UIViewController, walkProgramsViewController: UIViewController) {
        self.programsViewController = ProgramsContainer.assemble(with: .init()).viewController
        self.walkProgramsViewController = WalkProgramsContainer.assemble(with: .init()).viewController
    }
}

extension WorkoutRouter: WorkoutRouterInput {
    func getProgramsView() -> UIViewController {
        return programsViewController
    }
    
    func getWalkProgramsView() -> UIViewController {
        return walkProgramsViewController
    }
}
