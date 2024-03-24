//
//  DeleteAccountViewModel.swift
//  Everyday
//
//  Created by Yaz on 21.03.2024.
//

import UIKit
struct DeleteAccountViewModel {
    let deleteAcountTitle: NSAttributedString
    let emailFielfTitle: NSAttributedString
    let passwordFieldTitle: NSAttributedString
    let deleteButtonTitle: NSAttributedString
    init() {
        self.deleteAcountTitle = NSAttributedString(string: "DeleteAccount_title".localized, attributes: Styles.titleAttributesBold)
        self.emailFielfTitle = NSAttributedString(string: "DeleteAccount_EmailField_title".localized, attributes: Styles.titleAttributes)
        self.passwordFieldTitle = NSAttributedString(string: "DeleteAccount_PasswordField_title".localized, attributes: Styles.titleAttributes)
        self.deleteButtonTitle = NSAttributedString(string: "DeleteAccount_Delete_title".localized, attributes: Styles.titleAttributesRed)
    }
}

private extension DeleteAccountViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        static let titleAttributesRed: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        static let titleAttributesBold: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
    }
}
