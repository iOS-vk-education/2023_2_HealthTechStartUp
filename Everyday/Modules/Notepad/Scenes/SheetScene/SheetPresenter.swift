//
//  SheetPresenter.swift
//  Everyday
//
//  Created by Alexander on 12.04.2024.
//  
//

import Foundation

final class SheetPresenter<ContentViewInput: AnyObject> {
    weak var view: SheetViewInput?
    weak var moduleOutput: SheetModuleOutput?
    
    private let router: SheetRouterInput
    private let interactor: SheetInteractorInput
    private let moduleType: SheetType
    private let contentView: ContentViewInput
    
    init(router: SheetRouterInput, interactor: SheetInteractorInput, moduleType: SheetType, contentView: ContentViewInput) {
        self.router = router
        self.interactor = interactor
        self.moduleType = moduleType
        self.contentView = contentView
    }
}

extension SheetPresenter: SheetModuleInput {
}

extension SheetPresenter: SheetViewOutput {
    func didLoadView() {
        let viewModel = SheetViewModel(sheetType: moduleType)
        view?.configure(with: viewModel)
    }
    
    func didTapCloseButton() {
        router.dismissSheet()
    }
    
    func didTapSaveButton() {
//        moduleOutput?.setResult(of: exercise.name, with: String(result), at: indexOfSet)
        router.dismissSheet()
    }
}

extension SheetPresenter: SheetWeightViewOutput {
}

extension SheetPresenter: SheetStateViewOutput {
}

extension SheetPresenter: SheetInteractorOutput {
}
