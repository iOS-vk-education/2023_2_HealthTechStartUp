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
    func updateBodyWeightMeasureUnit(measureUnit: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        settingsService.updateMeasureUnit(measureUnit: measureUnit, measureUnitKey: Constants.bodyWeightKey) { result in
            completion(result)
        }
    }
    
    func updateMeasurementsMeasureUnit(measureUnit: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        settingsService.updateMeasureUnit(measureUnit: measureUnit, measureUnitKey: Constants.measurementsKey) { result in
            completion(result)
        }
    }
    
    func updateLoadWeightMeasureUnit(measureUnit: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        settingsService.updateMeasureUnit(measureUnit: measureUnit, measureUnitKey: Constants.loadWeightKey) { result in
            completion(result)
        }
    }
    
    func updateDistanceMeasureUnit(measureUnit: String, completion: @escaping (Result<Void, any Error>) -> Void) {
        settingsService.updateMeasureUnit(measureUnit: measureUnit, measureUnitKey: Constants.distanceKey) { result in
            completion(result)
        }
    }
    
    struct Constants {
        static let bodyWeightKey = "bodyWeightMeasureUnit"
        static let measurementsKey = "measurementsMeasureUnit"
        static let loadWeightKey = "loadWeightMeasureUnit"
        static let distanceKey = "distanceMeasureUnit"
    }
}
