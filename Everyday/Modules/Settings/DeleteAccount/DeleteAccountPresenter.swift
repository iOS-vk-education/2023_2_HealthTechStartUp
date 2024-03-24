//
//  DeleteAccountPresenter.swift
//  Everyday
//
//  Created by Yaz on 12.03.2024.
//
//

import Foundation

final class DeleteAccountPresenter {
    weak var view: DeleteAccountViewInput?
    weak var moduleOutput: DeleteAccountModuleOutput?
    
    private let router: DeleteAccountRouterInput
    private let interactor: DeleteAccountInteractorInput
    
    init(router: DeleteAccountRouterInput, interactor: DeleteAccountInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension DeleteAccountPresenter: DeleteAccountModuleInput {
}

extension DeleteAccountPresenter: DeleteAccountViewOutput {
    func getBack() {
        router.getBackToMainView()
    }
}

extension DeleteAccountPresenter: DeleteAccountInteractorOutput {
}
