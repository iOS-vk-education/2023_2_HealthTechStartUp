//
//  ChangePasswordInteractor.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class ChangePasswordInteractor {
    weak var output: ChangePasswordInteractorOutput?
    weak var viewController: UIViewController?
    
    private let settingsService: SettingsServiceDescription
    
    init(settingsService: SettingsServiceDescription) {
        self.settingsService = settingsService
    }
    
    private func performAuthAction(flag: Bool, viewController: UIViewController,
                                   action: (_ viewController: UIViewController, _ completion: @escaping (Result<Void, Error>) -> Void) -> Void,
                                   completion: @escaping (Result<Void, Error>) -> Void) {
        action(viewController) { result in
            completion(result)
        }
    }
}

extension ChangePasswordInteractor: ChangePasswordInteractorInput {
    func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let model = ChangePasswordModel(oldPassword: oldPassword, newPassword: newPassword)
        settingsService.changePassword(with: model) {result in
                completion(result)
        }
    }
}
