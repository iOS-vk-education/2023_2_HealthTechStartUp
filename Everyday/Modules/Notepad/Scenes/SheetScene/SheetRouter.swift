//
//  SheetRouter.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//  
//

import UIKit

final class SheetRouter {
    weak var viewController: SheetViewController?
}

extension SheetRouter: SheetRouterInput {
    func dismissSheet() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.dismiss(animated: true)
    }
}
