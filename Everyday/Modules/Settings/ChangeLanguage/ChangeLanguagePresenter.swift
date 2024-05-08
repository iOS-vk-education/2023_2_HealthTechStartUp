//
//  ChangeLanguagePresenter.swift
//  Everyday
//
//  Created by Yaz on 05.05.2024.
//  
//

import Foundation

final class ChangeLanguagePresenter {
    weak var view: ChangeLanguageViewInput?
    weak var moduleOutput: ChangeLanguageModuleOutput?
    
    private let router: ChangeLanguageRouterInput
    private let settingsUserDefaultsService: SettingsUserDefaultsService = SettingsUserDefaultsService.shared
    
    init(router: ChangeLanguageRouterInput) {
        self.router = router
    }
}

extension ChangeLanguagePresenter: ChangeLanguageModuleInput {
}

extension ChangeLanguagePresenter: ChangeLanguageViewOutput {
    func didTapEnCell() {
        settingsUserDefaultsService.setSelectedLanguage(language: Constants.enKey)
        Bundle.main.path(forResource: Constants.enKey, ofType: Constants.lproj)
    }
    
    func didTapRuCell() {
        settingsUserDefaultsService.setSelectedLanguage(language: Constants.ruKey)
        Bundle.main.path(forResource: Constants.ruKey, ofType: Constants.lproj)
    }
    
    func getCurrentLanguageIndexPath() -> IndexPath {
        let currentLanguage = UserDefaults.standard.stringArray(forKey: "AppleLanguages")
        switch currentLanguage?[0] {
        case Constants.enKey:
            return [0, 0]
        case Constants.ruKey:
            return [0, 1]
        default:
            return [0, 1]
        }
    }
    
    func didLoadView() {
        let viewModel = ChangeLanguageViewModel()
        view?.configure(with: viewModel)
    }
    
    func getChangeLanguageViewModel() -> ChangeLanguageViewModel {
        let model = ChangeLanguageViewModel()
        return model
    }
    
    func didSwipe() {
        router.getBackToMainView()
    }
    
    struct Constants {
        static let enKey: String = "en"
        static let ruKey: String = "ru"
        static let lproj: String = "lproj"
    }
}
