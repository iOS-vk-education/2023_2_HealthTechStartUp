//
//  ProfileViewModelForSingWithVKOrGoogle.swift
//  Everyday
//
//  Created by Yaz on 31.03.2024.
//

import UIKit

struct ProfileViewModelSingWithVKOrGoogle {
    let discriptionUsernameTitle: NSAttributedString
    let exitTitle: NSAttributedString
    let deleteAccount: NSAttributedString
    let sectionsModels: [[NSAttributedString]]
    init() {
        self.discriptionUsernameTitle = NSAttributedString(string: "Profile_DiscriptionUsername_title".localized, attributes: Styles.titleAttributes)
        self.exitTitle = NSAttributedString(string: "Profile_Exit_title".localized, attributes: Styles.titleAttributes)
        self.deleteAccount = NSAttributedString(string: "Profile_DeleteAccount_title".localized, attributes: Styles.titleAttributesRed)
        self.sectionsModels = [[discriptionUsernameTitle], [exitTitle], [deleteAccount]]
    }
}

private extension ProfileViewModelSingWithVKOrGoogle {
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
