//
//  ThemePresenter.swift
//  Everyday
//
//  Created by Yaz on 08.03.2024.
//
//

import Foundation

final class ThemePresenter {
    weak var view: ThemeViewInput?
    weak var moduleOutput: ThemeModuleOutput?
    
    private let router: ThemeRouterInput
    private let interactor: ThemeInteractorInput
    private let settingsUserDefaultsService: SettingsUserDefaultsService = SettingsUserDefaultsService.shared
    init(router: ThemeRouterInput, interactor: ThemeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ThemePresenter: ThemeModuleInput {
}

extension ThemePresenter: ThemeViewOutput {
    func getSelectedThemeCellIndexPath() -> IndexPath {
        settingsUserDefaultsService.getSelectedThemeCellIndexPath()
    }
    
    func didTapOnAutoThemeCell() {
        settingsUserDefaultsService.setAutoTheme()
    }
    
    func didTapOnLightThemeCell() {
        settingsUserDefaultsService.setLightTheme()
    }
    
    func didTapOnDarkThemeCell() {
        settingsUserDefaultsService.setDarkTheme()
    }
    
    func didLoadView() {
        let model = ThemeViewModel()
        view?.configure(with: model)
    }
    
    func getThemeViewModel() -> ThemeViewModel {
        let model = ThemeViewModel()
        return model
    }
    
    func didSwipe() {
        router.getBackToMainView()
    }
}

extension ThemePresenter: ThemeInteractorOutput {
}
