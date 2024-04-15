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
    
    weak var cameraView: CameraViewInput?
    weak var conditionChoiceView: ConditionChoiceViewInput?
    weak var weightMeasurementView: WeightMeasurementViewInput?
    
    private let router: SheetRouterInput
    private let interactor: SheetInteractorInput
    var moduleType: SheetType
    
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
        let viewModel = SheetViewModel(sheetType: moduleType)
        view?.configure(with: viewModel)
    }
    
    func didTapCloseButton() {
        router.dismissSheet()
    }
    
    func didTapSaveButton() {
        switch moduleType {
        case .camera:
            moduleOutput?.setResult(moduleType, at: 0)
        case .conditionChoice:
            moduleOutput?.setResult(moduleType, at: 1)
        case .heartRateVariability:
            moduleOutput?.setResult(moduleType, at: 2)
        case .weightMeasurement:
            moduleOutput?.setResult(moduleType, at: 3)
        }
        router.dismissSheet()
    }
}

extension SheetPresenter: SheetWeightViewOutput {
}

extension SheetPresenter: SheetStateViewOutput {
}

extension SheetPresenter: SheetInteractorOutput {
}