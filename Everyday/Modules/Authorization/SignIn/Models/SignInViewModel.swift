//
//  SignInViewModel.swift
//  welcome
//
//  Created by Михаил on 12.02.2024.
//

import UIKit

struct SignInViewModel {
    let googleImage: UIImage?
    let vkImage: UIImage?
    let anonymImage: UIImage?
    let separatorTitle: NSAttributedString
    let emailTitle: NSAttributedString
    let passwordTitle: NSAttributedString
    let signInTitle: NSAttributedString
    let forgotPasswordLabel: NSAttributedString
    let showPasswordImage: UIImage?
    let hidePasswordImage: UIImage?
    
    init() {
        self.googleImage = UIImage(named: "google")
        self.vkImage = UIImage(named: "vk")
        self.anonymImage = UIImage(named: "anonymous")
        self.separatorTitle = NSAttributedString(string: "SignUp_or_SignIn_separator_or".localized, attributes: Styles.titleAttributes)
        self.emailTitle = NSAttributedString(string: "Onboarding_user_email".localized, attributes: Styles.titleAttributes)
        self.passwordTitle = NSAttributedString(string: "Onboarding_user_password".localized, attributes: Styles.titleAttributes)
        self.signInTitle = NSAttributedString(string: "WelcomeScreen_or_Signin_button_title".localized, attributes: Styles.titleAttributes)
        self.hidePasswordImage = UIImage(systemName: "eye.slash.fill")
        self.showPasswordImage = UIImage(systemName: "eye.fill")
        self.forgotPasswordLabel = NSAttributedString(string: "SignIn_forgot_password_title".localized, attributes: Styles.linkAttributes)
    }
}

private extension SignInViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.grayElement,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        static let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.UI.accent,
            .font: UIFont.systemFont(ofSize: 14)
        ]
    }
}
