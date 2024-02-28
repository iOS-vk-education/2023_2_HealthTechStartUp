//
//  ExerciseRouter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class ExerciseRouter {
    weak var viewController: ExerciseViewController?
}

extension ExerciseRouter: ExerciseRouterInput {
    func closeExercise() {
        guard
            let viewController = viewController,
            let navigationController = viewController.navigationController
        else {
            return
        }
        
        navigationController.popViewController(animated: true)
    }
}
