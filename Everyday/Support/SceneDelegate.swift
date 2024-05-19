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
    private var splashPresenter: SplashPresenterDescription?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        
        splashPresenter = SplashPresenter(scene: scene)
        setupWindow(with: scene)
        
        let viewController = TabBarController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        SettingsUserDefaultsService.shared.setTheme()
        
        window?.rootViewController = viewController
        
        Reloader.shared.getAuthType()
        
        splashPresenter?.present()
        
        let delay: TimeInterval = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
                NotificationsService.shared.requestAuthorization()
            }
        }
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}
