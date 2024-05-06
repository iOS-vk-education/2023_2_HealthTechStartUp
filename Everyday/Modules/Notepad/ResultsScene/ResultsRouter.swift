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
        
        if let sheet = timerViewController.sheetPresentationController {
            sheet.detents = [
                .custom(resolver: { _ in
                    return Constants.timerSheetHeight
                })
            ]
        }
        
        viewController.present(timerViewController, animated: true)
    }
    
    func closeResults() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.dismiss(animated: true)
    }
}

private extension ResultsRouter {
    struct Constants {
        static let timerSheetHeight: CGFloat = 250
    }
}
