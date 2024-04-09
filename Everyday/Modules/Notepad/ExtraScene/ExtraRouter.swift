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
    func photoViewController() -> UIViewController {
        return UIViewController()
    }
    
    func stateViewController() -> UIViewController {
        return UIViewController()
    }
    
    func heartViewController() -> UIViewController {
        return UIViewController()
    }
    
    func weightViewController() -> UIViewController {
        return UIViewController()
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
            presentedViewController = photoViewController()
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
        
        if let sheet = presentedViewController.sheetPresentationController {
            sheet.detents = [
                .custom(resolver: { _ in
                    return Constants.sheetHeight
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
        static let sheetHeight: CGFloat = 250
    }
}
