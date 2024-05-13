//
//  UnitsRouter.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit

final class UnitsRouter {
    weak var viewController: UnitsViewController?
}

extension UnitsRouter: UnitsRouterInput {
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
