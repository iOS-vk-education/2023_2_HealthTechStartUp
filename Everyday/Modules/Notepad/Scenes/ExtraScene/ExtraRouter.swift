//
//  ExtraRouter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import UIKit

final class ExtraRouter {
    weak var viewController: ExtraViewController?
}

private extension ExtraRouter {
    func cameraViewController() -> UIViewController {
        let moduleType = SheetType.camera(model: .init())
        let context = SheetContext(type: moduleType)
        let container = SheetContainer.assemble(with: context)
        let presentedViewController = container.viewController
        presentedViewController.modalPresentationStyle = .overFullScreen
        
        return presentedViewController
    }
    
    func stateViewController() -> UIViewController {
        let moduleType = SheetType.conditionChoice(model: .init())
        let sheetSize = Constants.smallSheetHeight
        let context = SheetContext(type: moduleType)
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
    
    func heartViewController() -> UIViewController {
        let moduleType = SheetType.heartRateVariability(model: .init())
        let context = SheetContext(type: moduleType)
        let container = SheetContainer.assemble(with: context)
        let presentedViewController = container.viewController
        presentedViewController.modalPresentationStyle = .overFullScreen
        
        return presentedViewController
    }
    
    func weightViewController() -> UIViewController {
        let moduleType = SheetType.weightMeasurement(model: .init())
        let sheetSize = Constants.smallSheetHeight
        let context = SheetContext(type: moduleType)
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
    func showView(with type: ExtraViewType) {
        guard let viewController = viewController else {
            return
        }
        
        let presentedViewController: UIViewController?
        switch type {
        case .photo:
            presentedViewController = cameraViewController()
        case .state:
            presentedViewController = stateViewController()
        case .heart:
            presentedViewController = heartViewController()
        case .weight:
            presentedViewController = weightViewController()
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
