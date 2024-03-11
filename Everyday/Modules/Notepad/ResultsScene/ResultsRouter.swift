//
//  ResultsRouter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class ResultsRouter {
    weak var viewController: ResultsViewController?
}

extension ResultsRouter: ResultsRouterInput {
    func openTimer(with timerContext: TimerContext) {
        guard let viewController = viewController else {
            return
        }
        
        let timerContainer = TimerContainer.assemble(with: timerContext)
        let timerViewController = timerContainer.viewController
        viewController.present(timerViewController, animated: true)
    }
    
    func closeResults() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.dismiss(animated: true)
    }
}
