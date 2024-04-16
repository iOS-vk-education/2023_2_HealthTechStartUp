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
    private let settingsUserDefaultsService: SettingsUserDefaultsService = SettingsUserDefaultsService.shared
    
    init(router: UnitsRouterInput, interactor: UnitsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension UnitsPresenter: UnitsModuleInput {
}

extension UnitsPresenter: UnitsViewOutput {
    func getSelectedBodyWeightCellIndexPath() -> IndexPath {
        settingsUserDefaultsService.getSelectedBodyWeightCellIndexPath()
    }
    
    func getSelectedMeasurementsCellIndexPath() -> IndexPath {
        settingsUserDefaultsService.getSelectedMeasurementsCellIndexPath()
    }
    
    func getSelectedLoadWeightCellIndexPath() -> IndexPath {
        settingsUserDefaultsService.getSelectedLoadWeightCellIndexPath()
    }
    
    func getSelectedDistanceCellIndexPath() -> IndexPath {
        settingsUserDefaultsService.getSelectedDistanceCellIndexPath()
    }
    
    func didTapOnCellInBodyWeigthSection(row: Int) {
        settingsUserDefaultsService.setBodyWeightUnitType(row: row)
        
        interactor.updateBodyWeightMeasureUnit { result in
            switch result {
            case .success: print("success")
            case .failure(let error): print(error)
            }
        }
    }
    
    func didTapOnCellInMeasurementsSection(row: Int) {
        settingsUserDefaultsService.setMeasurementsUnitType(row: row)
        
        interactor.updateMeasurementsMeasureUnit { result in
            switch result {
            case .success: print("success")
            case .failure(let error): print(error)
            }
        }
    }
    
    func didTapOnCellInLoadWeigthSection(row: Int) {
        settingsUserDefaultsService.setLoadWeightUnitType(row: row)
        
        interactor.updateLoadWeightMeasureUnit { result in
            switch result {
            case .success: print("success")
            case .failure(let error): print(error)
            }
        }
    }
    
    func didTapOnCellInDistanceSection(row: Int) {
        settingsUserDefaultsService.setDistanceUnitType(row: row)
        
        interactor.updateDistanceMeasureUnit { result in
            switch result {
            case .success: print("success")
            case .failure(let error): print(error)
            }
        }
    }
    
    func didLoadView() {
        let viewModel = UnitsViewModel()
        view?.configure(with: viewModel)
    }
    
    func getUnitsViewModel() -> UnitsViewModel {
        let viewModel = UnitsViewModel()
        return viewModel
    }
    
    func didSwipe() {
        router.getBackToMainView()
    }
}

extension UnitsPresenter: UnitsInteractorOutput {
}
