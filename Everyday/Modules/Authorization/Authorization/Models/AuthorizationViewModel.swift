//
//  AuthorizationViewModel.swift
//  Everyday
//
//  Created by Михаил on 23.04.2024.
//

import UIKit

struct AuthorizationViewModel {  
    let googleImage: UIImage?
    let vkImage: UIImage?
    let appleImage: UIImage?
    let emailTitle: NSAttributedString
    let separatorTitle: NSAttributedString
    let privacyPolicyLabel: NSAttributedString
    
    init() {
        self.googleImage = UIImage(named: "google")
        self.vkImage = UIImage(named: "vk")
        self.appleImage = UIImage(named: "apple")
        self.emailTitle = NSAttributedString(string: "Authorization_email_title".localized, attributes: Styles.titleAttributes)
        self.separatorTitle = NSAttributedString(string: "SignUp_or_SignIn_separator_or".localized, attributes: Styles.titleAttributes)
        
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

private extension AuthorizationViewModel {
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
