//
//  ThemeProtocols.swift
//  Everyday
//
//  Created by Yaz on 08.03.2024.
//
//

import Foundation

protocol ThemeModuleInput {
    var moduleOutput: ThemeModuleOutput? { get }
}

protocol ThemeModuleOutput: AnyObject {
}

protocol ThemeViewInput: AnyObject {
    func configure(with: ThemeViewModel)
}

protocol ThemeViewOutput: AnyObject {
    func getSelectedThemeCellIndexPath() -> IndexPath
    func didTapOnAutoThemeCell()
    func didTapOnLightThemeCell()
    func didTapOnDarkThemeCell()
    func didLoadView()
    func getThemeViewModel() -> ThemeViewModel
    func didSwipe()
}

protocol ThemeRouterInput: AnyObject {
    func getBackToMainView()
}
