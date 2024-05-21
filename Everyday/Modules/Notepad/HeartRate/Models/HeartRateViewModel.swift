//
//  HeartRateViewModel.swift
//  AI_Everyday
//
//  Created by Михаил on 11.05.2024.
//

import UIKit

struct HeartRateViewModel {
    let stressTitleLabel: NSAttributedString
    let hrvTitleLabel: NSAttributedString
    let heartRateTitleLabel: NSAttributedString
    let startButtonTitle: NSAttributedString
    let stopButtonTitle: NSAttributedString
    let heartRateDescriptionLabel: NSAttributedString
    let hrvDescriptionLabel: NSAttributedString
    
    init() {
        self.stressTitleLabel = NSAttributedString(string: "HeartRateViewModel_stress".localized, attributes: Styles.titleAttributes)
        self.hrvTitleLabel = NSAttributedString(string: "HeartRateViewModel_hrv".localized, attributes: Styles.titleAttributes)
        self.heartRateTitleLabel = NSAttributedString(string: "HeartRateViewModel_rate".localized, attributes: Styles.titleAttributes)
        self.heartRateDescriptionLabel = NSAttributedString(string: "".localized, attributes: Styles.descriptionAttributes)
        self.hrvDescriptionLabel = NSAttributedString(string: "HeartRateViewModel_hrv_description".localized, attributes: Styles.descriptionAttributes)
        self.startButtonTitle = NSAttributedString(string: "Onboarding_start_button_title".localized, attributes: Styles.buttonAttributes)
        self.stopButtonTitle = NSAttributedString(string: "Timer_Stop_Button_Title".localized, attributes: Styles.buttonAttributes)
    }
}

extension HeartRateViewModel {
    struct Styles {
        static let paragraphStyle: NSMutableParagraphStyle = {
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            return style
        }()
        
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 20),
            .paragraphStyle: paragraphStyle
        ]
        
        static let buttonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 16),
            .paragraphStyle: paragraphStyle
        ]
        
        static let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 16),
            .paragraphStyle: paragraphStyle
        ]
    }
}
