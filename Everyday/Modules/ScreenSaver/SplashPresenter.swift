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
    private var index: Int = 0
    
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
    
    private lazy var text: NSAttributedString? = {
        
        let texts = SplashText()
        let textIndex = Int.random(in: 0..<texts.text.count)
        
        index = textIndex
        
        return texts.text[textIndex]
    }()
    
    // MARK: - Helpers
    
    private func splashWindow(windowLevel: UIWindow.Level, rootViewController: SplashViewController?) -> UIWindow {
        let splashWindow = UIWindow(windowScene: scene)
        
        splashWindow.windowLevel = windowLevel
        splashWindow.rootViewController = rootViewController
        splashWindow.makeKeyAndVisible()
        
        return splashWindow
    }
        
    private func splashViewController(with text: NSAttributedString?, logoIsHidden: Bool) -> SplashViewController? {
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

// MARK: - extension

struct SplashText {
    let text: [NSAttributedString]
    
    init() {
        text = [
            NSAttributedString(string: "SplashPresenter_text1".localized, attributes: Styles.titleAttributes),
            NSAttributedString(string: "SplashPresenter_text2".localized, attributes: Styles.titleAttributes),
            NSAttributedString(string: "SplashPresenter_text3".localized, attributes: Styles.titleAttributes),
            NSAttributedString(string: "SplashPresenter_text4".localized, attributes: Styles.titleAttributes),
            NSAttributedString(string: "SplashPresenter_text5".localized, attributes: Styles.titleAttributes),
            NSAttributedString(string: "SplashPresenter_text6".localized, attributes: Styles.titleAttributes),
            NSAttributedString(string: "SplashPresenter_text7".localized, attributes: Styles.titleAttributes),
            NSAttributedString(string: "SplashPresenter_text8".localized, attributes: Styles.titleAttributes),
            NSAttributedString(string: "SplashPresenter_text9".localized, attributes: Styles.titleAttributes),
            NSAttributedString(string: "SplashPresenter_text10".localized, attributes: Styles.titleAttributes)
        ]
    }
}

private extension SplashText {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 26)
        ]
    }
}
