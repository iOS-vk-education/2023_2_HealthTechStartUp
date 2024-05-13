//
//  ProfileViewModel.swift
//  Everyday
//
//  Created by Yaz on 01.04.2024.
//

import UIKit

struct ProfileViewModel {
    let profileTitle: NSAttributedString
    let selectImageTitle: NSAttributedString
    
    init() {
        self.profileTitle = NSAttributedString(string: "Profile_title".localized, attributes: Styles.titleAttributesBold)
        self.selectImageTitle = NSAttributedString(string: "Profile_SelectImage_title".localized, attributes: Styles.titleAttributes)
    }
}

private extension ProfileViewModel {
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
