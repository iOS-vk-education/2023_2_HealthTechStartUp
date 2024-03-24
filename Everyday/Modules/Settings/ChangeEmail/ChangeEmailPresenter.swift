//
//  ChangeEmailPresenter.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

final class ChangeEmailPresenter {
    weak var view: ChangeEmailViewInput?
    weak var moduleOutput: ChangeEmailModuleOutput?
    
    private let router: ChangeEmailRouterInput
    private let interactor: ChangeEmailInteractorInput
    
    init(router: ChangeEmailRouterInput, interactor: ChangeEmailInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ChangeEmailPresenter: ChangeEmailModuleInput {
}

extension ChangeEmailPresenter: ChangeEmailViewOutput {
    func getBack() {
        router.getBackToMainView()
    }
}

extension ChangeEmailPresenter: ChangeEmailInteractorOutput {
}
