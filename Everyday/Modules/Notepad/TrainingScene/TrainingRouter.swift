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
        guard let viewController = viewController else {
            return
        }
        
        let exerciseContainer = ExerciseContainer.assemble(with: exerciseContext)
        let exerciseViewController = exerciseContainer.viewController
        
        if let sheet = exerciseViewController.sheetPresentationController {
            sheet.detents = [
                .custom(resolver: { _ in
                    return Constants.sheetHeight
                })
            ]
        }
        
        viewController.present(exerciseViewController, animated: true)
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
    
    func openNotepad() {
        guard
            let viewController = viewController,
            let navigationController = viewController.navigationController
        else {
            return
        }
        
        navigationController.popToRootViewController(animated: true)
    }
}

private extension TrainingRouter {
    struct Constants {
        static let sheetHeight: CGFloat = 250
    }
}
