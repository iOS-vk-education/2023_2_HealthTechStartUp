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
            GenderUI(gender: .male, imageName: "male", localizedText: "male".localized),
            GenderUI(gender: .female, imageName: "female", localizedText: "female".localized),
            GenderUI(gender: .other, imageName: "other", localizedText: "other".localized)
        ]
    
    let title: NSAttributedString
    let description: NSAttributedString
    let next: NSAttributedString
    let skip: NSAttributedString
    
    init() {
        self.title = NSAttributedString(string: "onboard4_title".localized, attributes: Styles.titleAttributes)
        self.description = NSAttributedString(string: "onboard4_desc".localized, attributes: Styles.descriptionAttributes)
        self.next = NSAttributedString(string: "next".localized, attributes: Styles.buttonAttributes)
        self.skip = NSAttributedString(string: "skip".localized, attributes: Styles.buttonAttributes)
    }
}

private extension GenderViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.primaryText,
            .font: UIFont.systemFont(ofSize: 26)
        ]
        
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
