//
//  SheetPresenter.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//  
//

import Foundation

final class SheetPresenter: SheetActionOutput {
    let router: SheetRouterInput
    private let interactor: SheetInteractorInput
    
    weak var view: SheetViewInput?
    weak var moduleOutput: SheetModuleOutput?
        
    init(router: SheetRouterInput, interactor: SheetInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SheetPresenter: SheetModuleInput {
}

extension SheetPresenter: SheetViewOutput {
    func didLoadView() {
        print("[DEBUG] SheetPresenter didLoadView")
    }
}

extension SheetPresenter: SheetWeightViewOutput {
}

extension SheetPresenter: SheetStateViewOutput {
}

extension SheetPresenter: SheetInteractorOutput {
}
