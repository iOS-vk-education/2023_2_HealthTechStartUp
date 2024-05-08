//
//  DeleteAccountInteractor.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import UIKit

final class DeleteAccountInteractor {
    weak var output: DeleteAccountInteractorOutput?
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

extension DeleteAccountInteractor: DeleteAccountInteractorInput {
    func deleteAccount(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let whichSign = UserDefaults.standard.string(forKey: "WhichSign")

        switch whichSign {
        case "email":
            let model = DeleteAccountModel(email: email, password: password)
            settingsService.deleteEmailAccount(with: model, whichSign: whichSign!) { result in
                completion(result)
            }
        case "anonym":
            settingsService.deleteAnonymAccount(with: whichSign!) { result in
                completion(result)
            }
        case "google":
            settingsService.deleteGoogleAccount(with: whichSign!) { result in
                completion(result)
            }
        case "vk":
            settingsService.deleteVkAccount(with: whichSign!) { result in
                completion(result)
            }
        default:
            print("deleteAccount Error")
        }
    }
}
