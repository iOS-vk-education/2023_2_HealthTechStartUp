//
//  ChangeEmailInteractor.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class ChangeEmailInteractor {
    weak var output: ChangeEmailInteractorOutput?
    
    private let settingsService: SettingsServiceDescription
    
    init(settingsService: SettingsServiceDescription) {
        self.settingsService = settingsService
    }
}

extension ChangeEmailInteractor: ChangeEmailInteractorInput {
    func changeEmail(email: String, password: String) {
        let model = ChangeEmailModel(newEmail: email, password: password)
        settingsService.changeEmail(with: model) { result in
            self.output?.didChanged(result)
        }
    }
}
