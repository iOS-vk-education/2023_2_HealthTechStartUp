//
//  AgeViewModel.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import SwiftUI

struct AgeViewModel {
    let title: NSAttributedString
    let next: NSAttributedString
    let skip: NSAttributedString
    
    init() {
        self.title = NSAttributedString(string: "Onboarding_Age_title".localized, attributes: Styles.titleAttributes)
        self.next = NSAttributedString(string: "Onboarding_next_button_title".localized, attributes: Styles.buttonAttributes)
        self.skip = NSAttributedString(string: "Onboarding_skip_button_title".localized, attributes: Styles.buttonAttributes)
    }
}

private extension AgeViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 26)
        ]
        
        static let buttonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 18)
        ]
    }
}
