//
//  SplashPresenter.swift
//  Everyday
//
//  Created by Михаил on 28.02.2024.
//

import UIKit

protocol SplashPresenterDescription: AnyObject {
    func present()
    func dismiss(completion: @escaping () -> Void)
}

final class SplashPresenter: SplashPresenterDescription {
    
    // MARK: - Properties
    private let scene: UIWindowScene
    
    init(scene: UIWindowScene) {
        self.scene = scene
    }
    
    private lazy var animator: SplashAnimatorDescription = SplashAnimator(foregroundSplashWindow: foregroundSplashWindow,
                                                                          backgroundSplashWindow: backgroundSplashWindow)
    
    private lazy var foregroundSplashWindow: UIWindow = {
        let splashViewController = self.splashViewController(with: text, logoIsHidden: false)
        let splashWindow = self.splashWindow(windowLevel: .normal + 1, rootViewController: splashViewController)
        
        return splashWindow
    }()
    
    private lazy var backgroundSplashWindow: UIWindow = {
        let splashViewController = self.splashViewController(with: text, logoIsHidden: true)
        let splashWindow = self.splashWindow(windowLevel: .normal - 1, rootViewController: splashViewController)
        
        return splashWindow
    }()
    
    private lazy var text: String? = {
        let texts = ["Text1", "Text2", "Text3"]
        let textIndex = Int.random(in: 0..<texts.count)
        
        return texts[textIndex]
    }()
    
    // MARK: - Helpers
    
    private func splashWindow(windowLevel: UIWindow.Level, rootViewController: SplashViewController?) -> UIWindow {
        let splashWindow = UIWindow(windowScene: scene)
        
        splashWindow.windowLevel = windowLevel
        splashWindow.rootViewController = rootViewController
        splashWindow.makeKeyAndVisible()
        
        return splashWindow
    }
        
    private func splashViewController(with text: String?, logoIsHidden: Bool) -> SplashViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController")
        let splashViewController = viewController as? SplashViewController
        
        splashViewController?.text = text
        splashViewController?.logoIsHidden = logoIsHidden
        
        return splashViewController
    }
    
    // MARK: - SplashPresenterDescription
    
    func present() {
        animator.animateAppearance()
    }
    
    func dismiss(completion: @escaping () -> Void) {
        animator.animateDisappearance(completion: completion)
    }
}
