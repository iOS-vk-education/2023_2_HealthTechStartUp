//
//  TrainingRouter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class TrainingRouter {
    weak var viewController: TrainingViewController?
}

extension TrainingRouter: TrainingRouterInput {
    func openExercise(with exerciseContext: ExerciseContext) {
        guard
            let viewController = viewController,
            let navigationController = viewController.navigationController
        else {
            return
        }
        
        let exerciseContainer = ExerciseContainer.assemble(with: exerciseContext)
        navigationController.pushViewController(exerciseContainer.viewController, animated: true)
    }
    
    func showResults(with resultsContext: ResultsContext) {
        guard let viewController = viewController else {
            return
        }
        
        let resultsContainer = ResultsContainer.assemble(with: resultsContext)
        let resultsViewController = resultsContainer.viewController
        resultsViewController.modalPresentationStyle = .overFullScreen
        viewController.present(resultsViewController, animated: false)
    }
    
    func openExtra() {
        guard
            let viewController = viewController,
            let navigationController = viewController.navigationController
        else {
            return
        }
        
        let extraContainer = ExtraContainer.assemble(with: .init())
        navigationController.pushViewController(extraContainer.viewController, animated: true)
    }
}
