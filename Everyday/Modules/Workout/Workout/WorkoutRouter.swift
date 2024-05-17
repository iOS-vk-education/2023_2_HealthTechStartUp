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
    func openCatalogView(with newViewController: UIViewController) {
        guard let viewController = viewController  else {
            return
        }
        
        let navController = UINavigationController(rootViewController: newViewController)
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .coverVertical
        viewController.present(navController, animated: true, completion: nil)
    }
    
    func getProgramsView() -> UIViewController {
        return programsViewController
    }
    
    func getWalkProgramsView() -> UIViewController {
        return walkProgramsViewController
    }
}
