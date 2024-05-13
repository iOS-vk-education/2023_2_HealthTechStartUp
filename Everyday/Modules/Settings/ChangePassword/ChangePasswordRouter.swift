//
//  ChangePasswordRouter.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class ChangePasswordRouter {
    weak var viewController: ChangePasswordViewController?
}

extension ChangePasswordRouter: ChangePasswordRouterInput {
    func getForgotPasswordView() {
        guard let viewController = viewController else {
            return
        }
        viewController.navigationController?.present(ForgotPasswordViewController(authService: AuthService.shared), animated: true)
    }
    
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
