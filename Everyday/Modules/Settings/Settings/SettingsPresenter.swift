//
//  SettingsPresenter.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//
//

import Foundation

enum FeedBack {
    case problem
    case suggest
    case privacy
}

final class SettingsPresenter {
    weak var view: SettingsViewInput?
    weak var moduleOutput: SettingsModuleOutput?
    
    private let router: SettingsRouterInput
    private let interactor: SettingsInteractorInput
    
    init(router: SettingsRouterInput, interactor: SettingsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SettingsPresenter: SettingsModuleInput {
}

extension SettingsPresenter: SettingsViewOutput {
    func didTapSuggestCell() {
        interactor.openURL(with: .suggest)
    }
    
    func didTapPrivacyCell() {
        interactor.openURL(with: .privacy)
    }
    
    func didTapProblemCell() {
        interactor.openURL(with: .problem)
    }
    
    func didTapTellFriendsCell() {
        let textToShare = "Everyday"
        guard let url = URL(string: "https://t.me/everydayheal") else {
            return
        }
        
        let items: [Any] = [textToShare, url]
        router.getShareView(with: items)
    }
    
    func getViewModel() -> SettingsViewModel {
        let viewModel = SettingsViewModel()
        return viewModel
    }
    
    func didTapThemeCell() {
        router.getThemeView()
    }
    
    func didTapDateAndTimeCell() {
        router.getDateAndTimeView()
    }
    
    func didTapUnitsCell() {
        router.getUnitsView()
    }
    
    func didTapChangeLanguageCell() {
        router.getChangeLanguageView()
    }
    
    func didTapProfileCell() {
        router.getProfileView()
    }
    
    func didTapHealthCell() {
        router.getHealthView()
    }
}

extension SettingsPresenter: SettingsInteractorOutput {
    func didOpenURL(with appURL: URL, and webURL: URL) {
        router.openURL(appURL, webURL)
    }
    
    func didFailOpenURL() {
        print("alert manager will be placed here after merge new_auth")
    }
}
