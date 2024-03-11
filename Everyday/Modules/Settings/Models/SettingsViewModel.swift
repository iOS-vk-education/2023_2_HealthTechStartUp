//
//  SettingsViewModel.swift
//  Everyday
//
//  Created by Михаил on 29.02.2024.
//

import UIKit

struct SettingsViewModel {
    let logoutTitle: NSAttributedString
    
    init() {
        self.logoutTitle = NSAttributedString(string: "Settings_logout_title".localized, attributes: Styles.titleAttributes)
    }
}

private extension SettingsViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 18)
        ]
    }
}
