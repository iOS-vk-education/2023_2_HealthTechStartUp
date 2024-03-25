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
    func reloadData()
//    func confiure(with: SettingsViewModel)
}

protocol SettingsViewOutput: AnyObject {
    func didTapThemeCell()
    func didTapDateAndTimeCell()
    func didTapUnitsCell()
    func didTapProfileCell()
}

protocol SettingsInteractorInput: AnyObject {
}

protocol SettingsInteractorOutput: AnyObject {
}

protocol SettingsRouterInput: AnyObject {
    func getThemeView()
    func getDateAndTimeView()
    func getUnitsView()
    func getProfileView()
}
