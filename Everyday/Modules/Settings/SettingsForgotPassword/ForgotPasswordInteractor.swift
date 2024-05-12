//
//  ForgotPasswordInteractor.swift
//  Everyday
//
//  Created by Yaz on 14.04.2024.
//

import UIKit

final class ForgotPasswordInteractor {
    weak var output: ForgotPasswordInteractorOutput?
    
    private let settingsService: SettingsServiceDescription
    
    init(settingsService: SettingsServiceDescription) {
        self.settingsService = settingsService
    }
}

extension ForgotPasswordInteractor: ForgotPasswordInteractorInput {
    func sendForgotPasswordMessage(with email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        settingsService.sendForgotPasswordMessage(email: email) { result in
            completion(result)
        }
    }
}
