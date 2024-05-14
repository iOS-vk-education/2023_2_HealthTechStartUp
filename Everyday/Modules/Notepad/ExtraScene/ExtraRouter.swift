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
    func cameraViewController(with type: SheetType) -> UIViewController {
        let context = SheetContext(moduleOutput: presenter, type: type)
        let container = SheetContainer.assemble(with: context)
        let presentedViewController = container.viewController
        presentedViewController.modalPresentationStyle = .overFullScreen
        
        return presentedViewController
    }
    
    func stateViewController(with type: SheetType) -> UIViewController {
        let sheetSize = Constants.smallSheetHeight
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
    
    func heartViewController(with type: SheetType) -> UIViewController {
        let container = HeartRateContainer.assemble(with: .init())
        let presentedViewController = container.viewController
        
        return presentedViewController
    }
    
    func weightViewController(with type: SheetType) -> UIViewController {
        let sheetSize = Constants.smallSheetHeight
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

extension ExtraRouter: ExtraRouterInput {
    func showView(of type: SheetType) {
        var presentedViewController: UIViewController?
        switch type {
        case .camera:
            presentedViewController = cameraViewController(with: type)
        case .conditionChoice:
            presentedViewController = stateViewController(with: type)
        case .heartRateVariability:
            presentedViewController = heartViewController(with: type)
            viewController?.navigationController?.pushViewController(presentedViewController!, animated: true)
            return
        case .weightMeasurement:
            presentedViewController = weightViewController(with: type)
        default:
            break
        }
        guard let presentedViewController else {
            return
        }
        
        viewController?.present(presentedViewController, animated: true)
    }
    
    func openNotepad() {        
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}

private extension ExtraRouter {
    struct Constants {
        static let smallSheetHeight: CGFloat = 250
    }
}
