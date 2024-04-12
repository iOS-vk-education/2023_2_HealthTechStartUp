//
//  ThemePresenter.swift
//  Everyday
//
//  Created by Yaz on 08.03.2024.
//
//

import Foundation

final class ThemePresenter {
    weak var view: ThemeViewInput?
    weak var moduleOutput: ThemeModuleOutput?
    
    private let router: ThemeRouterInput
    private let interactor: ThemeInteractorInput
    
    init(router: ThemeRouterInput, interactor: ThemeInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ThemePresenter: ThemeModuleInput {
}

extension ThemePresenter: ThemeViewOutput {
    func didSwipe() {
        router.getBackToMainView()
    }
}

extension ThemePresenter: ThemeInteractorOutput {
}
