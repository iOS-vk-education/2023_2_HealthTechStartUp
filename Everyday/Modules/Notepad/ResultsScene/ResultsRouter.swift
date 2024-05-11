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
    func showView(with context: SheetContext) {
        let sheetContainer = SheetContainer.assemble(with: context)
        let presentedViewController = sheetContainer.viewController
        
        if let sheet = presentedViewController.sheetPresentationController {
            sheet.detents = [
                .custom(resolver: { _ in
                    return Constants.timerSheetHeight
                })
            ]
        }
        
        viewController?.present(presentedViewController, animated: true)
    }
    
    func dismissResults() {
        viewController?.dismiss(animated: true)
    }
}

private extension ResultsRouter {
    struct Constants {
        static let timerSheetHeight: CGFloat = 250
    }
}
