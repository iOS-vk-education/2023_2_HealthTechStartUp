//
//  ExtraRouter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class ExtraRouter {
    weak var presenter: ExtraPresenter?
    weak var viewController: ExtraViewController?
}

private extension ExtraRouter {
    func cameraViewController(with context: SheetType) -> UIViewController {
        let moduleType = SheetType.camera(model: .init())
        let context = SheetContext(moduleOutput: presenter, type: context)
        let container = SheetContainer.assemble(with: context)
        let presentedViewController = container.viewController
        presentedViewController.modalPresentationStyle = .overFullScreen
        
        return presentedViewController
    }
    
    func stateViewController(with context: SheetType) -> UIViewController {
        let moduleType = SheetType.conditionChoice(model: .init())
        let sheetSize = Constants.smallSheetHeight
        let context = SheetContext(moduleOutput: presenter, type: context)
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
    
    func heartViewController(with context: SheetType) -> UIViewController {
        let moduleType = SheetType.heartRateVariability(model: .init())
        let context = SheetContext(moduleOutput: presenter, type: moduleType)
        let container = SheetContainer.assemble(with: context)
        let presentedViewController = container.viewController
        presentedViewController.modalPresentationStyle = .overFullScreen
        
        return presentedViewController
    }
    
    func weightViewController(with context: SheetType) -> UIViewController {
        let moduleType = SheetType.weightMeasurement(model: .init())
        let sheetSize = Constants.smallSheetHeight
        let context = SheetContext(moduleOutput: presenter, type: context)
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

extension ExtraRouter: ExtraRouterInput {
    func showView(_ type: ExtraViewType, with context: SheetType) {
        guard let viewController = viewController else {
            return
        }
        
        let presentedViewController: UIViewController?
        switch type {
        case .photo:
            presentedViewController = cameraViewController(with: context)
        case .state:
            presentedViewController = stateViewController(with: context)
        case .heart:
            presentedViewController = heartViewController(with: context)
        case .weight:
            presentedViewController = weightViewController(with: context)
        }
        guard let presentedViewController else {
            return
        }
        
        viewController.present(presentedViewController, animated: true)
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

private extension ExtraRouter {
    struct Constants {
        static let smallSheetHeight: CGFloat = 250
    }
}
