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
}

extension DeleteAccountInteractor: DeleteAccountInteractorInput {
    func deleteAccount(email: String, password: String) {
        guard let whichSign = UserDefaults.standard.string(forKey: "WhichSign") else {
            return
        }

        switch whichSign {
        case "email":
            let model = DeleteAccountModel(email: email, password: password)
            settingsService.deleteEmailAccount(with: model, whichSign: whichSign) { result, reauth in
                self.output?.didDelete(result, reauth)
            }
            
        case "google":
            settingsService.deleteGoogleAccount(with: whichSign) { result in
                self.output?.didDelete(result, nil)
            }
            
        case "vk":
            settingsService.deleteVkAccount(with: whichSign) { result in
                self.output?.didDelete(result, nil)
            }
            
        default:
            print("deleteAccount Error")
        }
    }
}
