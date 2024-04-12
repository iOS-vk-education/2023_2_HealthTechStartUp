//
//  UnitsPresenter.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation

final class UnitsPresenter {
    weak var view: UnitsViewInput?
    weak var moduleOutput: UnitsModuleOutput?
    
    private let router: UnitsRouterInput
    private let interactor: UnitsInteractorInput
    
    init(router: UnitsRouterInput, interactor: UnitsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension UnitsPresenter: UnitsModuleInput {
}

extension UnitsPresenter: UnitsViewOutput {
    func didSwipe() {
        router.getBackToMainView()
    }
}

extension UnitsPresenter: UnitsInteractorOutput {
}
