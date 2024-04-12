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

extension ExtraRouter: ExtraRouterInput {
    func showView(with type: ExtraViewType) {
        guard let viewController = viewController else {
            return
        }
        
        let moduleType: SheetType?
        var sheetSize: CGFloat?
        switch type {
        case .photo:
            moduleType = SheetType.camera(viewModel: .init())
        case .state:
            moduleType = SheetType.conditionChoice(viewModel: .init())
            sheetSize = Constants.smallSheetHeight
        case .heart:
            moduleType = SheetType.heartRateVariability(viewModel: .init())
        case .weight:
            moduleType = SheetType.weightMeasurement(viewModel: .init())
            sheetSize = Constants.smallSheetHeight
        }
        guard let moduleType else {
            return
        }
        
        let context = SheetContext(type: moduleType)
        let container = SheetContainer.assemble(with: context)
        let presentedViewController = container.viewController
        
        if let sheet = presentedViewController.sheetPresentationController, sheetSize != nil {
            sheet.detents = [
                .custom(resolver: { _ in
                    return sheetSize
                })
            ]
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
