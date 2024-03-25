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
    func routeToAuthentication() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
    
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
