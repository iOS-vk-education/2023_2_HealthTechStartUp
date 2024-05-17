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
    func openTraining(with context: TrainingContext) {
        let trainingContainer = TrainingContainer.assemble(with: context)
        let trainingViewController = trainingContainer.viewController
        
        viewController?.navigationController?.pushViewController(trainingViewController, animated: true)
    }
    
    func openPrograms() {
    }
}
