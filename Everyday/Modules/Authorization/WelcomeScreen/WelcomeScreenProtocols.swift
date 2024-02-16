//
//  WelcomeScreenProtocols.swift
//  signup
//
//  Created by Михаил on 06.02.2024.
//  
//

import UIKit

protocol WelcomeScreenModuleInput {
    var moduleOutput: WelcomeScreenModuleOutput? { get }
}

protocol WelcomeScreenModuleOutput: AnyObject {
}

protocol WelcomeScreenViewInput: AnyObject {
    func configure(with: WelcomeScreenViewModel)
    func setSignUp(_ view: UIViewController)
    func setSignIn(_ view: UIViewController)
}

protocol WelcomeScreenViewOutput: AnyObject {
    func didLoadView()
    func getSignIn()
    func getSignUp()
}

protocol WelcomeScreenRouterInput: AnyObject {
    func getSignUpView() -> UIViewController
    func getSignInView() -> UIViewController
}
