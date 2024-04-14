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
    func getForgotPasswordView() {
        guard let viewController = viewController else {
            return
        }
        
        let forgotPasswordContainer = ForgotPasswordContainer.assemble(with: .init())
        let forgotPasswordViewController = forgotPasswordContainer.viewController
        forgotPasswordViewController.modalPresentationStyle = .overFullScreen
        viewController.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
