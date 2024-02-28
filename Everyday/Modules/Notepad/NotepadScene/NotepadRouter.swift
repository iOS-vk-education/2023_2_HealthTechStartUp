//
//  NotepadRouter.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit

final class NotepadRouter {
    weak var viewController: NotepadViewController?
}

extension NotepadRouter: NotepadRouterInput {
    func openTraining(with trainingContext: TrainingContext) {
        guard
            let viewController = viewController,
            let navigationController = viewController.navigationController
        else {
            return
        }
        
        let trainingContainer = TrainingContainer.assemble(with: trainingContext)
        navigationController.pushViewController(trainingContainer.viewController, animated: true)
    }
}
