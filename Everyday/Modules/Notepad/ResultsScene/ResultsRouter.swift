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
    weak var presenter: ResultsPresenter?
}

private extension ResultsRouter {
    func exerciseTimerViewController(with type: SheetType) -> UIViewController {
        let sheetSize = Constants.timerSheetHeight
        let context = SheetContext(moduleOutput: presenter, type: type)
        let container = SheetContainer.assemble(with: context)
        let presentedViewController = container.viewController
        if let sheet = presentedViewController.sheetPresentationController {
            sheet.detents = [
                .custom(resolver: { _ in
                    return sheetSize
                })
            ]
        }
        
        return presentedViewController
    }
}

extension ResultsRouter: ResultsRouterInput {
//    func openTimer(with timerContext: TimerContext) {
//        guard let viewController = viewController else {
//            return
//        }
//        
//        let timerContainer = TimerContainer.assemble(with: timerContext)
//        let timerViewController = timerContainer.viewController
//        
//        if let sheet = timerViewController.sheetPresentationController {
//            sheet.detents = [
//                .custom(resolver: { _ in
//                    return Constants.timerSheetHeight
//                })
//            ]
//        }
//        
//        viewController.present(timerViewController, animated: true)
//    }
    
    func showView(with context: SheetContext) {
        var presentedViewController: UIViewController?
        switch context.type {
        case .exerciseTimer:
            presentedViewController = exerciseTimerViewController(with: context.type)
        default:
            break
        }
        guard let presentedViewController else {
            return
        }
        
        viewController?.present(presentedViewController, animated: true)
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
