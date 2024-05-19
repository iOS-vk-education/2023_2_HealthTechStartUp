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
    func showView(with context: SheetContext) {
        let sheetContainer = SheetContainer.assemble(with: context)
        let presentedViewController = sheetContainer.viewController
        
        if let sheet = presentedViewController.sheetPresentationController {
            sheet.detents = [
                .custom(resolver: { _ in
                    return Constants.sheetHeight
                })
            ]
        }
        
        viewController?.present(presentedViewController, animated: true)
    }
    
    func showResults(with context: ResultsContext) {
        let resultsContainer = ResultsContainer.assemble(with: context)
        let resultsViewController = resultsContainer.viewController
        resultsViewController.modalPresentationStyle = .overFullScreen
        
        viewController?.present(resultsViewController, animated: false)
    }
    
    func openExtra(with context: ExtraContext) {
        let extraContainer = ExtraContainer.assemble(with: context)
        let extraViewController = extraContainer.viewController
        extraViewController.navigationItem.hidesBackButton = true
        
        viewController?.navigationController?.pushViewController(extraViewController, animated: true)
    }
}

private extension TrainingRouter {
    struct Constants {
        static let sheetHeight: CGFloat = 250
    }
}
