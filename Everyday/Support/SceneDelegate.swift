//
//  SceneDelegate.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//

import UIKit
import VKID
import FirebaseAuth

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
        window?.rootViewController = viewController
        
        splashPresenter?.present()
        
        reloadAuthentication()
        
        let delay: TimeInterval = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
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
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            self?.window?.rootViewController = nav
        }
    }
    
    private func reloadAuthentication() {
        guard Auth.auth().currentUser == nil else {
            return
        }
        
        let authTypeArray: [String] = [
            KeychainService.loadString(for: "vkAuth") ?? "",
            KeychainService.loadString(for: "googleAuth") ?? "",
            KeychainService.loadString(for: "anonymAuth") ?? "",
            KeychainService.loadString(for: "emailAuth") ?? ""
        ]
        
        CoreDataService.shared.deleteAllItems()
        for authType in authTypeArray where !authType.isEmpty {
            CoreDataService.shared.createItem(authType: authType)
        }
    }
}
