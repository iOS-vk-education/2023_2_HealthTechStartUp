//
//  SceneDelegate.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//

import UIKit
import VKID

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }

        let viewController = WelcomeScreenContainer.assemble(with: .init()).viewController
        let navigationController = UINavigationController(rootViewController: viewController)

        let window = UIWindow(windowScene: scene)
        self.window = window

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
