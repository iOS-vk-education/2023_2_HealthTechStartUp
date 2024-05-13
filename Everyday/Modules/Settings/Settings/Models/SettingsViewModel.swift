//
//  SettingsViewModel.swift
//  Everyday
//
//  Created by Yaz on 01.03.2024.
//

import UIKit

struct SettingsViewModel {
    let settingsTitle: NSAttributedString
    let supportEverydayTitle: String
    
    let profileSettingsSectionCellModel: SettingsTableViewCellModel
    let healthSettingsSectionCellModel: SettingsTableViewCellModel
    let tellFriendsSectionCellModel: SettingsTableViewCellModel
    let generalSettingsSectionCellModel: [SettingsTableViewCellModel]
    let aboutAppSettingsSectionCellModel: [SettingsTableViewCellModel]
    
    let soundsImage: UIImage?
    let autolockImage: UIImage?
    let themeImage: UIImage?
    let dateAndTimeImage: UIImage?
    let unitsImage: UIImage?
    let profileImage: UIImage?
    let healthImage: UIImage?
    let problemImage: UIImage?
    let suggestImprovementsImage: UIImage?
    let termsAndPrivacyImage: UIImage?
    let tellFriendsImage: UIImage?
    let languageImage: UIImage?
    
    let soundsTitle: NSAttributedString
    let autolockTitle: NSAttributedString
    let themeTitle: NSAttributedString
    let dateAndTimeTitle: NSAttributedString
    let unitsTitle: NSAttributedString
    let languageTitle: NSAttributedString
    let profileTitle: NSAttributedString
    let healthTitle: NSAttributedString
    let problemTitle: NSAttributedString
    let suggestImprovementsTitle: NSAttributedString
    let termsAndPrivacyTitle: NSAttributedString
    let tellFriendsTitle: NSAttributedString
    let tyTitle: NSAttributedString
    
    init() {
        self.healthImage              = UIImage(systemName: "suit.heart.fill")
        self.soundsImage              = UIImage(systemName: "speaker.wave.2.fill")
        self.autolockImage            = UIImage(systemName: "lock.rotation")
        self.themeImage               = UIImage(systemName: "circle.lefthalf.filled")
        self.dateAndTimeImage         = UIImage(systemName: "clock")
        self.unitsImage               = UIImage(systemName: "ruler")
        self.languageImage            = UIImage(systemName: "ellipsis.message")
        self.profileImage             = UIImage(systemName: "person.text.rectangle")
        self.problemImage             = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
        self.suggestImprovementsImage = UIImage(systemName: "plus.bubble")
        self.termsAndPrivacyImage     = UIImage(systemName: "menucard")
        self.tellFriendsImage         = UIImage(systemName: "person.3")
        
        self.healthTitle              = NSAttributedString(string: "Settings_Health_title".localized, attributes: Styles.titleAttributes)
        self.settingsTitle            = NSAttributedString(string: "Settings_title".localized, attributes: Styles.titleAttributes)
        self.soundsTitle              = NSAttributedString(string: "Settings_Sounds_title".localized, attributes: Styles.titleAttributes)
        self.autolockTitle            = NSAttributedString(string: "Settings_Autolock_title".localized, attributes: Styles.titleAttributes)
        self.themeTitle               = NSAttributedString(string: "Settings_Theme_title".localized, attributes: Styles.titleAttributes)
        self.dateAndTimeTitle         = NSAttributedString(string: "Settings_DateAndTime_title".localized, attributes: Styles.titleAttributes)
        self.unitsTitle               = NSAttributedString(string: "Settings_Units_title".localized, attributes: Styles.titleAttributes)
        self.languageTitle            = NSAttributedString(string: "Settings_Language_title".localized, attributes: Styles.titleAttributes)
        self.profileTitle             = NSAttributedString(string: "Settings_Profile_title".localized, attributes: Styles.titleAttributes)
        self.problemTitle             = NSAttributedString(string: "Settings_ReportAboutProblem_title".localized, attributes: Styles.titleAttributes)
        self.suggestImprovementsTitle = NSAttributedString(string: "Settings_SuggestImprovements_title".localized, attributes: Styles.titleAttributes)
        self.termsAndPrivacyTitle     = NSAttributedString(string: "Settings_TermsAndPrivacy_title".localized, attributes: Styles.titleAttributes)
        self.tellFriendsTitle         = NSAttributedString(string: "Settings_TellFriends_title".localized, attributes: Styles.titleAttributes)
        self.tyTitle                  = NSAttributedString(string: "Settings_TnxForUsing_title".localized, attributes: Styles.titleAttributes)
        
        self.supportEverydayTitle     = "Settings_SupportEveryday_title".localized
        
        self.generalSettingsSectionCellModel = [SettingsTableViewCellModel(cellImage: soundsImage, cellTitle: soundsTitle),
                                                SettingsTableViewCellModel(cellImage: autolockImage, cellTitle: autolockTitle),
                                                SettingsTableViewCellModel(cellImage: themeImage, cellTitle: themeTitle),
                                                SettingsTableViewCellModel(cellImage: dateAndTimeImage, cellTitle: dateAndTimeTitle),
                                                SettingsTableViewCellModel(cellImage: unitsImage, cellTitle: unitsTitle),
                                                SettingsTableViewCellModel(cellImage: languageImage, cellTitle: languageTitle)]
        
        self.aboutAppSettingsSectionCellModel = [SettingsTableViewCellModel(cellImage: problemImage, cellTitle: problemTitle),
                                                 SettingsTableViewCellModel(cellImage: suggestImprovementsImage, cellTitle: suggestImprovementsTitle),
                                                 SettingsTableViewCellModel(cellImage: termsAndPrivacyImage, cellTitle: termsAndPrivacyTitle)]
        
        self.profileSettingsSectionCellModel = SettingsTableViewCellModel(cellImage: profileImage, cellTitle: profileTitle)
        self.tellFriendsSectionCellModel = SettingsTableViewCellModel(cellImage: tellFriendsImage, cellTitle: tellFriendsTitle)
        self.healthSettingsSectionCellModel = SettingsTableViewCellModel(cellImage: healthImage, cellTitle: healthTitle)
    }
}

struct SettingsTableViewCellModel {
    let cellImage: UIImage?
    let cellTitle: NSAttributedString
}

private extension SettingsViewModel {
    struct Styles {
        static let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.Text.primary,
            .font: UIFont.systemFont(ofSize: 16)
        ]
    }
}
