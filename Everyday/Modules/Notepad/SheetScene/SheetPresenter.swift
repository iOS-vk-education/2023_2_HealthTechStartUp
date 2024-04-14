//
//  SheetPresenter.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//  
//

import Foundation

final class SheetPresenter {
    weak var view: SheetViewInput?
    weak var moduleOutput: SheetModuleOutput?
    
    private let router: SheetRouterInput
    private let interactor: SheetInteractorInput
    private let moduleType: SheetType
    
    init(router: SheetRouterInput, interactor: SheetInteractorInput, moduleType: SheetType) {
        self.router = router
        self.interactor = interactor
        self.moduleType = moduleType
    }
}

extension SheetPresenter: SheetModuleInput {
}

extension SheetPresenter: SheetViewOutput {
    func didLoadView() {
        let viewModel = SheetViewModel()
        view?.configure(with: viewModel)
    }
}

extension SheetPresenter: SheetWeightViewOutput {
}

extension SheetPresenter: SheetStateViewOutput {
}

extension SheetPresenter: SheetInteractorOutput {
}
