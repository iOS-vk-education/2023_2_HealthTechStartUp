//
//  ChangeEmailRouter.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class ChangeEmailRouter {
    weak var viewController: ChangeEmailViewController?
}

extension ChangeEmailRouter: ChangeEmailRouterInput {
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
