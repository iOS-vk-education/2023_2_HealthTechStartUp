//
//  UnitsPresenter.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation
import UIKit

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
    
    func didTapOnCellInBodyWeigthSection(indexPath: IndexPath) {
        let measureUnit: String = {
            switch indexPath.row {
            case 0: return Constants.kgs
            case 1: return Constants.pounds
            case 2: return Constants.stones
            default: return Constants.kgs
            }
        }()
        
        self.interactor.updateBodyWeightMeasureUnit(measureUnit: measureUnit, section: indexPath.section)
    }
    
    func didTapOnCellInMeasurementsSection(indexPath: IndexPath) {
        let measureUnit: String = {
            switch indexPath.row {
            case 0: return Constants.centimeters
            case 1: return Constants.inches
            default: return Constants.centimeters
            }
        }()
        
        self.interactor.updateMeasurementsMeasureUnit(measureUnit: measureUnit, section: indexPath.section)
    }
    
    func didTapOnCellInLoadWeigthSection(indexPath: IndexPath) {
        let measureUnit: String = {
            switch indexPath.row {
            case 0: return Constants.kgs
            case 1: return Constants.pounds
            case 2: return Constants.stones
            default: return Constants.kgs
            }
        }()
    
        self.interactor.updateLoadWeightMeasureUnit(measureUnit: measureUnit, section: indexPath.section)
    }
    
    func didTapOnCellInDistanceSection(indexPath: IndexPath) {
        let measureUnit: String = {
            switch indexPath.row {
            case 0: return Constants.kilometers
            case 1: return Constants.miles
            default: return Constants.kilometers
            }
        }()
        
        self.interactor.updateDistanceMeasureUnit(measureUnit: measureUnit, section: indexPath.section)
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
    
    struct Constants {
        static let kgs = "kg"
        static let pounds = "lb"
        static let stones = "st"
        static let centimeters = "centimeters"
        static let inches = "inches"
        static let kilometers = "kilometers"
        static let miles = "miles"
    }
}

extension UnitsPresenter: UnitsInteractorOutput {
    func didUpdate(measureUnit: String?, section: Int?, result: Result<Void, any Error>) {
        switch result {
        case .success:
            switch section {
            case 0: 
                self.settingsUserDefaultsService.setBodyWeightUnitType(measureUnit: measureUnit ?? "")
                self.view?.reloadData()
            case 1:
                self.settingsUserDefaultsService.setMeasurementsUnitType(measureUnit: measureUnit ?? "")
                self.view?.reloadData()
            case 2:
                self.settingsUserDefaultsService.setLoadWeightUnitType(measureUnit: measureUnit ?? "")
                self.view?.reloadData()
            case 3:
                self.settingsUserDefaultsService.setDistanceUnitType(measureUnit: measureUnit ?? "")
                self.view?.reloadData()
            default:
                print("error")
            }
        case .failure(let error):
            print(error)
        }
    }
}
