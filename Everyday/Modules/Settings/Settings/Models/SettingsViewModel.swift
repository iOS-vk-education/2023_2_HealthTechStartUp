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
    let generalSettingsSectionCellModel: [SettingsTableViewCellModel]
    let profileSettingsSectionCellModel: [SettingsTableViewCellModel]
    let aboutAppSettingsSectionCellModel: [SettingsTableViewCellModel]
    let tellFriendsSectionCellModel: [SettingsTableViewCellModel]
    
    let soundsImage: UIImage?
    let autolockImage: UIImage?
    let themeImage: UIImage?
    let dateAndTimeImage: UIImage?
    let unitsImage: UIImage?
    let profileImage: UIImage?
    let problemImage: UIImage?
    let suggestImprovementsImage: UIImage?
    let termsAndPrivacyImage: UIImage?
    let tellFriendsImage: UIImage?
    
    let soundsTitle: NSAttributedString
    let autolockTitle: NSAttributedString
    let themeTitle: NSAttributedString
    let dateAndTimeTitle: NSAttributedString
    let unitsTitle: NSAttributedString
    let profileTitle: NSAttributedString
    let problemTitle: NSAttributedString
    let suggestImprovementsTitle: NSAttributedString
    let termsAndPrivacyTitle: NSAttributedString
    let tellFriendsTitle: NSAttributedString
    let tyTitle: NSAttributedString
    
    init() {
        self.settingsTitle = NSAttributedString(string: "Settings_title".localized, attributes: Styles.titleAttributes)
        self.soundsImage = UIImage(systemName: "speaker.wave.2.fill")?.withRenderingMode(.alwaysOriginal)
        self.soundsTitle = NSAttributedString(string: "Settings_Sounds_title".localized, attributes: Styles.titleAttributes)
        self.autolockImage = UIImage(systemName: "lock.rotation")?.withRenderingMode(.alwaysOriginal)
        self.autolockTitle = NSAttributedString(string: "Settings_Autolock_title".localized, attributes: Styles.titleAttributes)
        self.themeImage = UIImage(systemName: "circle.lefthalf.filled")?.withRenderingMode(.alwaysOriginal)
        self.themeTitle = NSAttributedString(string: "Settings_Theme_title".localized, attributes: Styles.titleAttributes)
        self.dateAndTimeImage = UIImage(systemName: "clock")?.withRenderingMode(.alwaysOriginal)
        self.dateAndTimeTitle = NSAttributedString(string: "Settings_DateAndTime_title".localized, attributes: Styles.titleAttributes)
        self.unitsImage = UIImage(systemName: "ruler")?.withRenderingMode(.alwaysOriginal)
        self.unitsTitle = NSAttributedString(string: "Settings_Units_title".localized, attributes: Styles.titleAttributes)
        self.profileImage = UIImage(systemName: "person.text.rectangle")?.withRenderingMode(.alwaysOriginal)
        self.profileTitle = NSAttributedString(string: "Settings_Profile_title".localized, attributes: Styles.titleAttributes)
        self.problemImage = UIImage(systemName: "person.crop.circle.badge.exclamationmark")?.withRenderingMode(.alwaysOriginal)
        self.problemTitle = NSAttributedString(string: "Settings_ReportAboutProblem_title".localized, attributes: Styles.titleAttributes)
        self.suggestImprovementsImage = UIImage(systemName: "plus.bubble")?.withRenderingMode(.alwaysOriginal)
        self.suggestImprovementsTitle = NSAttributedString(string: "Settings_SuggestImprovements_title".localized, attributes: Styles.titleAttributes)
        self.termsAndPrivacyImage = UIImage(systemName: "menucard")?.withRenderingMode(.alwaysOriginal)
        self.termsAndPrivacyTitle = NSAttributedString(string: "Settings_TermsAndPrivacy_title".localized, attributes: Styles.titleAttributes)
        self.tellFriendsImage = UIImage(systemName: "person.3")?.withRenderingMode(.alwaysOriginal)
        self.tellFriendsTitle = NSAttributedString(string: "Settings_TellFriends_title".localized, attributes: Styles.titleAttributes)
        self.supportEverydayTitle = "Settings_SupportEveryday_title".localized
        self.tyTitle = NSAttributedString(string: "Settings_TnxForUsing_title".localized, attributes: Styles.titleAttributes)
        self.generalSettingsSectionCellModel = [SettingsTableViewCellModel(cellImage: soundsImage, cellTitle: soundsTitle),
        SettingsTableViewCellModel(cellImage: autolockImage, cellTitle: autolockTitle),
        SettingsTableViewCellModel(cellImage: themeImage, cellTitle: themeTitle),
        SettingsTableViewCellModel(cellImage: dateAndTimeImage, cellTitle: dateAndTimeTitle),
                                                SettingsTableViewCellModel(cellImage: unitsImage, cellTitle: unitsTitle)
        ]
        self.profileSettingsSectionCellModel = [SettingsTableViewCellModel(cellImage: profileImage, cellTitle: profileTitle)]
        self.aboutAppSettingsSectionCellModel = [SettingsTableViewCellModel(cellImage: problemImage, cellTitle: problemTitle),
        SettingsTableViewCellModel(cellImage: suggestImprovementsImage, cellTitle: suggestImprovementsTitle),
        SettingsTableViewCellModel(cellImage: termsAndPrivacyImage, cellTitle: termsAndPrivacyTitle)]
        self.tellFriendsSectionCellModel = [SettingsTableViewCellModel(cellImage: tellFriendsImage, cellTitle: tellFriendsTitle)]
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
