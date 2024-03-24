//
//  ChangePasswordPresenter.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

final class ChangePasswordPresenter {
    weak var view: ChangePasswordViewInput?
    weak var moduleOutput: ChangePasswordModuleOutput?
    
    private let router: ChangePasswordRouterInput
    private let interactor: ChangePasswordInteractorInput
    
    init(router: ChangePasswordRouterInput, interactor: ChangePasswordInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ChangePasswordPresenter: ChangePasswordModuleInput {
}

extension ChangePasswordPresenter: ChangePasswordViewOutput {
    func getBack() {
        router.getBackToMainView()
    }
}

extension ChangePasswordPresenter: ChangePasswordInteractorOutput {
}
