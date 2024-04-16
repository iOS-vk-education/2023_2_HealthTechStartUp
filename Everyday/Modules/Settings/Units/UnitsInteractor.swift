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
    
    let settingsService: SettingsServiceDescription
    
    private let userDefaults = UserDefaults.standard
    
    init(settingsService: SettingsServiceDescription) {
        self.settingsService = settingsService
    }
}

extension UnitsInteractor: UnitsInteractorInput {
    func updateBodyWeightMeasureUnit(completion: @escaping (Result<Void, any Error>) -> Void) {
        let bodyWeightMeasureUnit = userDefaults.string(forKey: Constants.bodyWeightKey) ?? ""
        settingsService.updateMeasureUnit(measureUnit: bodyWeightMeasureUnit, measureUnitKey: Constants.bodyWeightKey) { result in
            completion(result)
        }
    }
    
    func updateMeasurementsMeasureUnit(completion: @escaping (Result<Void, any Error>) -> Void) {
        let bodyWeightMeasureUnit = userDefaults.string(forKey: Constants.measurementsKey) ?? ""
        settingsService.updateMeasureUnit(measureUnit: bodyWeightMeasureUnit, measureUnitKey: Constants.measurementsKey) { result in
            completion(result)
        }
    }
    
    func updateLoadWeightMeasureUnit(completion: @escaping (Result<Void, any Error>) -> Void) {
        let bodyWeightMeasureUnit = userDefaults.string(forKey: Constants.loadWeightKey) ?? ""
        settingsService.updateMeasureUnit(measureUnit: bodyWeightMeasureUnit, measureUnitKey: Constants.loadWeightKey) { result in
            completion(result)
        }
    }
    
    func updateDistanceMeasureUnit(completion: @escaping (Result<Void, any Error>) -> Void) {
        let bodyWeightMeasureUnit = userDefaults.string(forKey: Constants.distanceKey) ?? ""
        settingsService.updateMeasureUnit(measureUnit: bodyWeightMeasureUnit, measureUnitKey: Constants.distanceKey) { result in
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
