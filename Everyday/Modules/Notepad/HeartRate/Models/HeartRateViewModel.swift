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
        self.stressTitleLabel = NSAttributedString(string: "Stress", attributes: Styles.titleAttributes)
        self.hrvTitleLabel = NSAttributedString(string: "HRV", attributes: Styles.titleAttributes)
        self.heartRateTitleLabel = NSAttributedString(string: "Heart Rate", attributes: Styles.titleAttributes)
        self.heartRateDescriptionLabel = NSAttributedString(string: "BPM", attributes: Styles.descriptionAttributes)
        self.hrvDescriptionLabel = NSAttributedString(string: "SDNN (ms)", attributes: Styles.descriptionAttributes)
        self.startButtonTitle = NSAttributedString(string: "Start", attributes: Styles.buttonAttributes)
        self.stopButtonTitle = NSAttributedString(string: "Stop", attributes: Styles.buttonAttributes)
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
