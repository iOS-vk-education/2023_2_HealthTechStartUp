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
    let signInTitle: NSAttributedString
    let signUpTitle: NSAttributedString
    
    init() {
        self.signInTitle = NSAttributedString(string: "WelcomeScreen_or_Signin_button_title".localized, attributes: Styles.titleAttributes)
        self.signUpTitle = NSAttributedString(string: "WelcomeScreen_signup_button_title".localized, attributes: Styles.titleAttributes)
    }
}

private extension WelcomeScreenViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
    }
}
