//
//  DeleteAccountRouter.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class DeleteAccountRouter {
    weak var viewController: DeleteAccountViewController?
}

extension DeleteAccountRouter: DeleteAccountRouterInput {
    func getForgotPasswordView() {
        guard let viewController = viewController else {
            return
        }
        viewController.navigationController?.present(ForgotPasswordViewController(authService: AuthService.shared), animated: true)
    }
    
    func routeToAuthentication() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            Reloader.shared.setLogout()
        }
    }
    
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
