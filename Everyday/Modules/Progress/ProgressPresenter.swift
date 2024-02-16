//
//  ProgressPresenter.swift
//  Everyday
//
//  Created by Михаил on 16.02.2024.
//  
//

import Foundation

final class ProgressPresenter {
    weak var view: ProgressViewInput?
    weak var moduleOutput: ProgressModuleOutput?
    
    private let router: ProgressRouterInput
    private let interactor: ProgressInteractorInput
    
    init(router: ProgressRouterInput, interactor: ProgressInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ProgressPresenter: ProgressModuleInput {
}

extension ProgressPresenter: ProgressViewOutput {
}

extension ProgressPresenter: ProgressInteractorOutput {
}
