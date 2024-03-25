//
//  ChangeEmailViewModel.swift
//  Everyday
//
//  Created by Yaz on 21.03.2024.
//

import UIKit

struct ChangeEmailViewModel {
    let changeEmailTitle: NSAttributedString
    let newEmailFieldTitle: NSAttributedString
    let passwordFieldTitle: NSAttributedString
    let confirmButtonTitle: NSAttributedString
    init() {
        self.changeEmailTitle = NSAttributedString(string: "ChangeEmail_title".localized, attributes: Styles.titleAttributesBold)
        self.newEmailFieldTitle = NSAttributedString(string: "ChangeEmail_NewEmailField_title".localized, attributes: Styles.titleAttributes)
        self.passwordFieldTitle = NSAttributedString(string: "ChangeEmail_PasswordField_title".localized, attributes: Styles.titleAttributes)
        self.confirmButtonTitle = NSAttributedString(string: "ChangeEmail_ConfirmButton_title".localized, attributes: Styles.titleAttributes)
    }
}
private extension ChangeEmailViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        static let titleAttributesBold: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
    }
}
