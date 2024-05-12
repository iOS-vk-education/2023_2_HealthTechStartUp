//
//  ProfileRouter.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import UIKit

final class ProfileRouter {
    weak var viewController: ProfileViewController?
}

extension ProfileRouter: ProfileRouterInput {
    func routeToAuthentication() {
//        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
//            sceneDelegate.checkAuthentication()
//        }
    }
    
    func getChangeEmailView() {
        guard let viewController = viewController else {
            return
        }
        
        let changeEmailContainer = ChangeEmailContainer.assemble(with: .init())
        let changeEmailViewController = changeEmailContainer.viewController
        changeEmailViewController.modalPresentationStyle = .overFullScreen
        viewController.navigationController?.pushViewController(changeEmailViewController, animated: true)
    }
    
    func getChangePasswordView() {
        guard let viewController = viewController else {
            return
        }
        
        let changePasswordContainer = ChangePasswordContainer.assemble(with: .init())
        let changePasswordViewController = changePasswordContainer.viewController
        changePasswordViewController.modalPresentationStyle = .overFullScreen
        viewController.navigationController?.pushViewController(changePasswordViewController, animated: true)
    }
    
    func getDeleteAccountView() {
        guard let viewController = viewController else {
            return
        }
        
        let deleteAccountContainer = DeleteAccountContainer.assemble(with: .init())
        let deleteAccountViewController = deleteAccountContainer.viewController
        deleteAccountViewController.modalPresentationStyle = .overFullScreen
        viewController.navigationController?.pushViewController(deleteAccountViewController, animated: true)
    }
    
    func getBackToMainView() {
        guard let viewController = viewController else {
            return
        }
        
        viewController.navigationController?.popViewController(animated: true)
    }
}
