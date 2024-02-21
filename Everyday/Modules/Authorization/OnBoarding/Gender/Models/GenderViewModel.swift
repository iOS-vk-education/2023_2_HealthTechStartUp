//
//  GenderViewModel.swift
//  welcome
//
//  Created by Михаил on 14.02.2024.
//

import SwiftUI

struct GenderViewModel {
    
    struct GenderUI {
           let gender: Gender
           let imageName: String
           let localizedText: String
       }
    
    let gendersUI: [GenderUI] = [
            GenderUI(gender: .male, imageName: "male", localizedText: "Onboarding_user_gender_male".localized),
            GenderUI(gender: .female, imageName: "female", localizedText: "Onboarding_user_gender_female".localized),
            GenderUI(gender: .other, imageName: "other", localizedText: "Onboarding_user_gender_other".localized)
        ]
    
    let title: NSAttributedString
    let next: NSAttributedString
    let skip: NSAttributedString
    
    init() {
        self.title = NSAttributedString(string: "Onboarding_Gender_title".localized, attributes: Styles.descriptionAttributes)
        self.next = NSAttributedString(string: "Onboarding_next_button_title".localized, attributes: Styles.buttonAttributes)
        self.skip = NSAttributedString(string: "Onboarding_skip_button_title".localized, attributes: Styles.buttonAttributes)
    }
}

private extension GenderViewModel {
    struct Styles {
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 24)
        ]
        
        static let buttonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 18)
        ]
    }
}
