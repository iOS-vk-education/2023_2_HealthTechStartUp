//
//  ForgotPasswordViewModel.swift
//  Everyday
//
//  Created by Yaz on 14.04.2024.
//

import UIKit

struct ForgotPasswordViewModel {
    let forgotPasswordTitle: NSAttributedString
    let emailFieldTitle: NSAttributedString
    let confirmButtonTitle: NSAttributedString
    
    init() {
        self.forgotPasswordTitle = NSAttributedString(string: "ForgotPassword_title", attributes: Styles.titleAttributesBold)
        self.emailFieldTitle = NSAttributedString(string: "ForgotPassword_EmailField_title", attributes: Styles.titleAttributes)
        self.confirmButtonTitle = NSAttributedString(string: "Восстановить", attributes: Styles.titleAttributes)
    }
}

private extension ForgotPasswordViewModel {
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
