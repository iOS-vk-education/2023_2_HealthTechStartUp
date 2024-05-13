//
//  WalkProgramsPresenter.swift
//  workout
//
//  Created by Михаил on 31.03.2024.
//  
//

import Foundation

final class WalkProgramsPresenter {
    weak var view: WalkProgramsViewInput?
    weak var moduleOutput: WalkProgramsModuleOutput?
    
    private let router: WalkProgramsRouterInput
    private let interactor: WalkProgramsInteractorInput
    
    init(router: WalkProgramsRouterInput, interactor: WalkProgramsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension WalkProgramsPresenter: WalkProgramsModuleInput {
}

extension WalkProgramsPresenter: WalkProgramsViewOutput {
    func didLoadView() {
        let viewModel = WalkProgramsViewModel()
        view?.configure(with: viewModel)
    }    
}

extension WalkProgramsPresenter: WalkProgramsInteractorOutput {
}
