//
//  UnitsInteractor.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation

final class UnitsInteractor {
    weak var output: UnitsInteractorOutput?
    
    private let settingsService: SettingsServiceDescription
    
    init(settingsService: SettingsServiceDescription) {
        self.settingsService = settingsService
    }
}

extension UnitsInteractor: UnitsInteractorInput {
    func updateBodyWeightMeasureUnit(measureUnit: String, section: Int?) {
        settingsService.updateMeasureUnit(measureUnit: measureUnit, measureUnitKey: Constants.bodyWeightKey) { result in
            self.output?.didUpdate(measureUnit: measureUnit, section: section, result: result)
        }
    }
    
    func updateMeasurementsMeasureUnit(measureUnit: String, section: Int?) {
        settingsService.updateMeasureUnit(measureUnit: measureUnit, measureUnitKey: Constants.measurementsKey) { result in
            self.output?.didUpdate(measureUnit: measureUnit, section: section, result: result)
        }
    }
    
    func updateLoadWeightMeasureUnit(measureUnit: String, section: Int?) {
        settingsService.updateMeasureUnit(measureUnit: measureUnit, measureUnitKey: Constants.loadWeightKey) { result in
            self.output?.didUpdate(measureUnit: measureUnit, section: section, result: result)
        }
    }
    
    func updateDistanceMeasureUnit(measureUnit: String, section: Int?) {
        settingsService.updateMeasureUnit(measureUnit: measureUnit, measureUnitKey: Constants.distanceKey) { result in
            self.output?.didUpdate(measureUnit: measureUnit, section: section, result: result)
        }
    }
    
    struct Constants {
        static let bodyWeightKey = "bodyWeightMeasureUnit"
        static let measurementsKey = "measurementsMeasureUnit"
        static let loadWeightKey = "loadWeightMeasureUnit"
        static let distanceKey = "distanceMeasureUnit"
    }
}
