//
//  ForgotPasswordViewModel.swift
//  Everyday
//
//  Created by Михаил on 27.04.2024.
//

import UIKit

struct ForgotPasswordViewModel {
    let titleLabelText: NSAttributedString
    let emailTextFieldPlaceholder: NSAttributedString
    let continueButtonTitle: NSAttributedString
    
    init() {
        self.titleLabelText = NSAttributedString(string: "ForgotPasswordViewController_title".localized, attributes: Styles.titleAttributes)
        self.emailTextFieldPlaceholder = NSAttributedString(string: "Onboarding_user_email".localized, attributes: Styles.descriptionAttributes)
        self.continueButtonTitle = NSAttributedString(string: "Results_Continue_Button_Title".localized, attributes: Styles.descriptionAttributes)
    }
}

private extension ForgotPasswordViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.boldSystemFont(ofSize: 28)
        ]
        
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.grayElement,
            .font: UIFont.systemFont(ofSize: 16)
        ]
    }
}
