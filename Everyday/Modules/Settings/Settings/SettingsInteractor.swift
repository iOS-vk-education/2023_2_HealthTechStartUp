//
//  SettingsInteractor.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import UIKit

final class SettingsInteractor {
    weak var output: SettingsInteractorOutput?
    let authService: AuthServiceDescription
    
    init(authService: AuthServiceDescription) {
        self.authService = authService
    }
}

extension SettingsInteractor: SettingsInteractorInput {
}
