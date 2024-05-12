//
//  SettingsProtocols.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//
//

import Foundation
import UIKit

protocol SettingsModuleInput {
    var moduleOutput: SettingsModuleOutput? { get }
}

protocol SettingsModuleOutput: AnyObject {
}

protocol SettingsViewInput: AnyObject {
}

protocol SettingsViewOutput: AnyObject {
    func getViewModel() -> SettingsViewModel
    func didTapThemeCell()
    func didTapDateAndTimeCell()
    func didTapUnitsCell()
    func didTapChangeLanguageCell()
    func didTapProfileCell()
    func didTapHealthCell()
    func didTapTellFriendsCell()
    func didTapProblemCell()
    func didTapSuggestCell()
    func didTapPrivacyCell()
}

protocol SettingsInteractorInput: AnyObject {
    func openURL(with type: FeedBack)
}

protocol SettingsInteractorOutput: AnyObject {
    func didOpenURL(with appURL: URL, and webURL: URL)
    func didFailOpenURL()
}

protocol SettingsRouterInput: AnyObject {
    func getThemeView()
    func getDateAndTimeView()
    func getUnitsView()
    func getChangeLanguageView()
    func getProfileView()
    func getAuthView()
    func getHealthView()
    func getShareView(with items: [Any])
    func openURL(_ appUrl: URL, _ webUrl: URL)
}

protocol TableViewDelegateSelection: AnyObject {
    func didSelectRowAt(_ indexPath: IndexPath)
}
