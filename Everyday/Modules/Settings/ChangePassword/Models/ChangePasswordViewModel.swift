//
//  ChangePasswordViewModel.swift
//  Everyday
//
//  Created by Yaz on 21.03.2024.
//

import UIKit

struct ChangePasswordViewModel {
    let changePasswordTitle: NSAttributedString
    let oldPasswordFieldTitle: NSAttributedString
    let newPasswordFieldTitle: NSAttributedString
    let confirmButtonTitle: NSAttributedString
    let forgotPasswordTitle: NSAttributedString
    
    init() {
        self.changePasswordTitle = NSAttributedString(string: "ChangePassword_title".localized, attributes: Styles.titleAttributesBold)
        self.oldPasswordFieldTitle = NSAttributedString(string: "ChangePassword_OldPasswordField_title".localized, attributes: Styles.titleAttributes)
        self.newPasswordFieldTitle = NSAttributedString(string: "ChangePassword_NewPasswordField_title".localized, attributes: Styles.titleAttributes)
        self.confirmButtonTitle = NSAttributedString(string: "ChangePassword_ConfirmButton_title".localized, attributes: Styles.titleAttributes)
        self.forgotPasswordTitle = NSAttributedString(string: "ForgotPassword_title".localized, attributes: Styles.titleAttributes)
    }
}
private extension ChangePasswordViewModel {
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
