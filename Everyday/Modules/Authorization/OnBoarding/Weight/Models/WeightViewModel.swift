//
//  WeightViewModel.swift
//  welcome
//
//  Created by Михаил on 15.02.2024.
//

import Foundation

import SwiftUI

struct WeightViewModel {
    let title: NSAttributedString
    let next: NSAttributedString
    let skip: NSAttributedString
    let placeholder: String
    
    init() {
        self.title = NSAttributedString(string: "Onboarding_Weight_title".localized, attributes: Styles.titleAttributes)
        self.next = NSAttributedString(string: "Onboarding_next_button_title".localized, attributes: Styles.buttonAttributes)
        self.skip = NSAttributedString(string: "Onboarding_skip_button_title".localized, attributes: Styles.buttonAttributes)
        self.placeholder = "Onboarding_Weight_description".localized
    }
}

private extension WeightViewModel {
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
