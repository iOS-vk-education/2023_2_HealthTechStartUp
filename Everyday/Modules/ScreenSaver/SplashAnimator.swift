//
//  SplashAnimator.swift
//  Everyday
//
//  Created by Михаил on 28.02.2024.
//

import UIKit
import QuartzCore

protocol SplashAnimatorDescription: AnyObject {
    func animateAppearance()
    func animateDisappearance(completion: @escaping () -> Void)
}

final class SplashAnimator: SplashAnimatorDescription {
    
    private unowned let foregroundSplashWindow: UIWindow
    private unowned let backgroundSplashWindow: UIWindow
    
    private unowned let foregroundSplashViewController: SplashViewController
    private unowned let backgroundSplashViewController: SplashViewController
    
    init(foregroundSplashWindow: UIWindow, backgroundSplashWindow: UIWindow) {
        self.foregroundSplashWindow = foregroundSplashWindow
        self.backgroundSplashWindow = backgroundSplashWindow
        
        guard let foregroundSplashViewController = foregroundSplashWindow.rootViewController as? SplashViewController,
              let backgroundSplashViewController = backgroundSplashWindow.rootViewController as? SplashViewController else {
            fatalError("Splash window doesn't have splash root view controller!")
        }
        
        self.foregroundSplashViewController = foregroundSplashViewController
        self.backgroundSplashViewController = backgroundSplashViewController
    }
    
    func animateAppearance() {
        foregroundSplashWindow.isHidden = false

        foregroundSplashViewController.logoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        foregroundSplashViewController.textLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        foregroundSplashViewController.logoImageView.alpha = 0
        foregroundSplashViewController.textLabel.alpha = 0

        UIView.animate(withDuration: 0.5, animations: {
            self.foregroundSplashViewController.logoImageView.transform = .identity
            self.foregroundSplashViewController.textLabel.transform = .identity
            self.foregroundSplashViewController.logoImageView.alpha = 1
            self.foregroundSplashViewController.textLabel.alpha = 1
        })
    }
    
    func animateDisappearance(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, animations: {
            self.foregroundSplashViewController.logoImageView.alpha = 0
            self.foregroundSplashViewController.textLabel.alpha = 0
            self.foregroundSplashViewController.logoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.foregroundSplashViewController.textLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: { _ in
            self.backgroundSplashWindow.isHidden = true
            self.foregroundSplashWindow.isHidden = true
            completion()
        })
    }
}
