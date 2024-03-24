//
//  DateAndTimeViewModel.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//

import UIKit

struct DateAndTimeViewModel {
    let dateAndTimeTitle: NSAttributedString
    let sundayTitle: NSAttributedString
    let mondayTitle: NSAttributedString
    let weekStartsTitle: NSAttributedString
    let militaryTimeFormatTitle: NSAttributedString
    let amPmFormatTitle: NSAttributedString
    let hoursFormatTitle: NSAttributedString
    let weekStartsSectionModel: [NSAttributedString]
    let hoursFormatSectionModel: [NSAttributedString]
    
    init() {
        self.dateAndTimeTitle = NSAttributedString(string: "DateAndTime_title".localized, attributes: Styles.titleAttributesBold)
        self.sundayTitle = NSAttributedString(string: "DateAndTime_Sunday_title".localized, attributes: Styles.titleAttributes)
        self.mondayTitle = NSAttributedString(string: "DateAndTime_Monday_title".localized, attributes: Styles.titleAttributes)
        self.weekStartsTitle = NSAttributedString(string: "DateAndTime_BeginningOfTheWeek_title".localized, attributes: Styles.titleAttributes)
        self.militaryTimeFormatTitle = NSAttributedString(string: "DateAndTime_MilitaryTimeFormat_title".localized, attributes: Styles.titleAttributes)
        self.amPmFormatTitle = NSAttributedString(string: "DateAndTime_AmPmTimeFormat_title".localized, attributes: Styles.titleAttributes)
        self.hoursFormatTitle = NSAttributedString(string: "DateAndTime_HoursFormat_title".localized, attributes: Styles.titleAttributes)
        self.weekStartsSectionModel = [sundayTitle, mondayTitle]
        self.hoursFormatSectionModel = [militaryTimeFormatTitle, amPmFormatTitle]
    }
}

private extension DateAndTimeViewModel {
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
