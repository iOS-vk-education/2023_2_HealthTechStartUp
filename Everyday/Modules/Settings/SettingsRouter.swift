//
//  SettingsRouter.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit

final class SettingsRouter {
    weak var viewController: SettingsViewController?
}

extension SettingsRouter: SettingsRouterInput {
    func routeToAuthentication() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
}
