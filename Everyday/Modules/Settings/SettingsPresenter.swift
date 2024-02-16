//
//  SettingsPresenter.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

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
}

extension SettingsPresenter: SettingsInteractorOutput {
}
