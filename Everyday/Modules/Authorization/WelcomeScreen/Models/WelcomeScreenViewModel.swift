//
//  WelcomeScreenViewModel.swift
//  welcome
//
//  Created by Egor Korotkii on 2/8/24.
//

import UIKit

enum ActivePage {
    case signUp
    case signIn
}

struct WelcomeScreenViewModel {
    let logoImage: UIImage?
    let signInTitle: NSAttributedString
    let signUpTitle: NSAttributedString
    
    init() {
        self.logoImage = UIImage(named: "logo")
        self.signInTitle = NSAttributedString(string: "sign_title".localized, attributes: Styles.titleAttributes)
        self.signUpTitle = NSAttributedString(string: "registration_title".localized, attributes: Styles.titleAttributes)
    }
}

private extension WelcomeScreenViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 18)
        ]
    }
}
