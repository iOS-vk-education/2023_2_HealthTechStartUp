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
    weak var viewController: UIViewController?
    let authService: AuthServiceDescription
    
    init(authService: AuthServiceDescription) {
        self.authService = authService
    }
}

extension SettingsInteractor: SettingsInteractorInput {
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        authService.logout { result in
            completion(result)
        }
    }
}
