//
//  TrainingRouter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class TrainingRouter {
    weak var presenter: TrainingPresenter?
    weak var viewController: TrainingViewController?
}

private extension TrainingRouter {
    func exerciseCounterViewController(with type: SheetType) -> UIViewController {
        let sheetSize = Constants.sheetHeight
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
    
    func exerciseTimerViewController(with type: SheetType) -> UIViewController {
        let sheetSize = Constants.sheetHeight
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

extension TrainingRouter: TrainingRouterInput {
//    func showExercise(with exerciseContext: ExerciseContext) {
//        guard let viewController = viewController else {
//            return
//        }
//        
//        let exerciseContainer = ExerciseContainer.assemble(with: exerciseContext)
//        let exerciseViewController = exerciseContainer.viewController
//        
//        if let sheet = exerciseViewController.sheetPresentationController {
//            sheet.detents = [
//                .custom(resolver: { _ in
//                    return Constants.sheetHeight
//                })
//            ]
//        }
//        
//        viewController.present(exerciseViewController, animated: true)
//    }

    func showView(with context: SheetContext) {
        var presentedViewController: UIViewController?
        switch context.type {
        case .exerciseCounter:
            presentedViewController = exerciseCounterViewController(with: context.type)
        default:
            break
        }
        guard let presentedViewController else {
            return
        }
        
        viewController?.present(presentedViewController, animated: true)
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
    
    func openExtra(with extraContext: ExtraContext) {
        guard
            let viewController = viewController,
            let navigationController = viewController.navigationController
        else {
            return
        }
        
        let extraContainer = ExtraContainer.assemble(with: extraContext)
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
