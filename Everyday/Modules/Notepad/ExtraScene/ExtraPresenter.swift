//
//  ExtraPresenter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

final class ExtraPresenter {
    weak var view: ExtraViewInput?
    weak var moduleOutput: ExtraModuleOutput?
    
    private let router: ExtraRouterInput
    private let interactor: ExtraInteractorInput
    
    init(router: ExtraRouterInput, interactor: ExtraInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ExtraPresenter: ExtraModuleInput {
}

extension ExtraPresenter: ExtraViewOutput {
}

extension ExtraPresenter: ExtraInteractorOutput {
}
