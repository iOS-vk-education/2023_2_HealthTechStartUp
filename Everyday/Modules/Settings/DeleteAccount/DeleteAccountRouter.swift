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
        guard let viewController = viewController else {
            return
        }
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let tabBarController = window.rootViewController as? TabBarController {
            viewController.navigationController?.popToRootViewController(animated: true)
            tabBarController.selectedIndex = 2 // Или индекс вашей вкладки, которую вы хотите выбрать после авторизации
        } else {
            let tabBarViewController = TabBarController()
            viewController.navigationController?.pushViewController(tabBarViewController, animated: true)
        }
    }

    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
