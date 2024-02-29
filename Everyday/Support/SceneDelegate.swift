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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if Auth.auth().currentUser == nil {
            if let viewController = storyboard.instantiateViewController(withIdentifier: "WelcomeScreenViewController") as? WelcomeScreenViewController {
               window?.rootViewController = viewController
            }
        } else {
            if let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
               window?.rootViewController = viewController
            }
        }
        
        splashPresenter?.present()
        
        let delay: TimeInterval = 1.5
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.splashPresenter?.dismiss { [weak self] in
                self?.splashPresenter = nil
            }
        }
        
        checkAuthentication()
    }
    
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        let window = UIWindow(windowScene: windowScene)
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            self.goToController(with: WelcomeScreenContainer.assemble(with: .init()).viewController)
        } else {
            self.goToController(with: TabBarController())
        }
    }
    
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            let nav = UINavigationController(rootViewController: viewController)
            if viewController is TabBarController {
                nav.setNavigationBarHidden(true, animated: false)
            }
            nav.modalPresentationStyle = .fullScreen
            self?.window?.rootViewController = nav
        }
    }
}
