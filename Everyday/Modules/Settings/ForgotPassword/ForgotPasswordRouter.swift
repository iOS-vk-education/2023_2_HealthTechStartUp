//
//  ForgotPasswordRouter.swift
//  Everyday
//
//  Created by Yaz on 14.04.2024.
//

import UIKit

final class ForgotPasswordRouter {
    weak var viewController: ForgotPasswordViewController?
}

extension ForgotPasswordRouter: ForgotPasswordRouterInput {
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
