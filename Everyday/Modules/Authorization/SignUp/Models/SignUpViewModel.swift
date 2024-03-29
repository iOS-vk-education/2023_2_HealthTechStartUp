//
//  SignUpViewModel.swift
//  welcome
//
//  Created by Михаил on 08.02.2024.
//

import UIKit

struct SignUpViewModel {
    let googleImage: UIImage?
    let vkImage: UIImage?
    let anonymImage: UIImage?
    let separatorTitle: NSAttributedString
    let emailTitle: NSAttributedString
    let passwordTitle: NSAttributedString
    let signUpTitle: NSAttributedString
    let privacyPolicyLabel: NSAttributedString
    let showPasswordImage: UIImage?
    let hidePasswordImage: UIImage?
    
    init() {
        self.googleImage = UIImage(named: "google")
        self.vkImage = UIImage(named: "vk")
        self.anonymImage = UIImage(named: "anonymous")
        self.separatorTitle = NSAttributedString(string: "SignUp_or_SignIn_separator_or".localized, attributes: Styles.titleAttributes)
        self.emailTitle = NSAttributedString(string: "Onboarding_user_email".localized, attributes: Styles.titleAttributes)
        self.passwordTitle = NSAttributedString(string: "Onboarding_user_password".localized, attributes: Styles.titleAttributes)
        self.signUpTitle = NSAttributedString(string: "SignUp_create_account_title".localized, attributes: Styles.titleAttributes)
        self.hidePasswordImage = UIImage(systemName: "eye.slash.fill")
        self.showPasswordImage = UIImage(systemName: "eye.fill")
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(NSAttributedString(string: "SignUp_title_p&p1".localized, attributes: Styles.titleLinkAttributes))
        combinedAttributedString.append(NSAttributedString(string: "\n", attributes: Styles.titleLinkAttributes))
        combinedAttributedString.append(NSAttributedString(string: "SignUp_title_p&p2".localized, attributes: Styles.linkAttributes))
        combinedAttributedString.append(NSAttributedString(string: " ", attributes: Styles.linkAttributes))
        combinedAttributedString.append(NSAttributedString(string: "SignUp_title_and".localized, attributes: Styles.titleLinkAttributes))
        combinedAttributedString.append(NSAttributedString(string: " ", attributes: Styles.titleLinkAttributes))
        combinedAttributedString.append(NSAttributedString(string: "SignUp_title_p&p3".localized, attributes: Styles.linkAttributes))
        
        self.privacyPolicyLabel = combinedAttributedString
    }
}

private extension SignUpViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.grayElement,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        static let linkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.UI.accent,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        static let titleLinkAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.grayElement,
            .font: UIFont.systemFont(ofSize: 14)
        ]
    }
}
