//
//  UnitsProtocols.swift
//  Everyday
//
//  Created by Yaz on 10.03.2024.
//
//

import Foundation

protocol UnitsModuleInput {
    var moduleOutput: UnitsModuleOutput? { get }
}

protocol UnitsModuleOutput: AnyObject {
}

protocol UnitsViewInput: AnyObject {
    func configure(with: UnitsViewModel)
    func showAlert(with key: String, message: String)
}

protocol UnitsViewOutput: AnyObject {
    func getSelectedBodyWeightCellIndexPath() -> IndexPath
    func getSelectedMeasurementsCellIndexPath() -> IndexPath
    func getSelectedLoadWeightCellIndexPath() -> IndexPath
    func getSelectedDistanceCellIndexPath() -> IndexPath
    func didTapOnCellInBodyWeigthSection(row: Int)
    func didTapOnCellInMeasurementsSection(row: Int)
    func didTapOnCellInLoadWeigthSection(row: Int)
    func didTapOnCellInDistanceSection(row: Int)
    func didLoadView()
    func getUnitsViewModel() -> UnitsViewModel
    func didSwipe()
}

protocol UnitsInteractorInput: AnyObject {
    func updateBodyWeightMeasureUnit(completion: @escaping (Result<Void, Error>) -> Void)
    func updateMeasurementsMeasureUnit(completion: @escaping (Result<Void, Error>) -> Void)
    func updateLoadWeightMeasureUnit(completion: @escaping (Result<Void, Error>) -> Void)
    func updateDistanceMeasureUnit(completion: @escaping (Result<Void, Error>) -> Void)
}

protocol UnitsInteractorOutput: AnyObject {
}

protocol UnitsRouterInput: AnyObject {
    func getBackToMainView()
}
