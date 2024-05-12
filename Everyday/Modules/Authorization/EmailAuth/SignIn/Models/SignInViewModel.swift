//
//  SignInViewModel.swift
//  Everyday
//
//  Created by Михаил on 27.04.2024.
//

import UIKit

struct SignInViewModel {
    let titleLabelText: NSAttributedString
    let emailTextFieldPlaceholder: NSAttributedString
    let passwordTextFieldPlaceholder: NSAttributedString
    let loginButtonTitle: NSAttributedString
    let signupButtonTitle: NSAttributedString
    let showPasswordImage: UIImage?
    let hidePasswordImage: UIImage?
    
    // localizable
    init() {
        self.titleLabelText = NSAttributedString(string: "SignInViewController_title".localized, attributes: Styles.titleAttributes)
        self.emailTextFieldPlaceholder = NSAttributedString(string: "Onboarding_user_email".localized, attributes: Styles.descriptionAttributes)
        self.passwordTextFieldPlaceholder = NSAttributedString(string: "Onboarding_user_password".localized, attributes: Styles.descriptionAttributes)
        self.loginButtonTitle = NSAttributedString(string: "WelcomeScreen_or_Signin_button_title".localized, attributes: Styles.descriptionAttributes)
        self.hidePasswordImage = UIImage(systemName: "eye.slash.fill")
        self.showPasswordImage = UIImage(systemName: "eye.fill")
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(NSAttributedString(string: "SignInViewController_signup1".localized, attributes: Styles.titleLinkAttributes))
        combinedAttributedString.append(NSAttributedString(string: "SignInViewController_signup2".localized, attributes: Styles.linkAttributes))
        
        self.signupButtonTitle = combinedAttributedString
    }
}

private extension SignInViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.boldSystemFont(ofSize: 28)
        ]
        
        static let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.UI.accent,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.grayElement,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        static let titleLinkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 16)
        ]
    }
}
