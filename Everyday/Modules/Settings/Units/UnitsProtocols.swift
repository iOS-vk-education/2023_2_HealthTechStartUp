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
    func reloadData()
}

protocol UnitsViewOutput: AnyObject {
    func getSelectedBodyWeightCellIndexPath() -> IndexPath
    func getSelectedMeasurementsCellIndexPath() -> IndexPath
    func getSelectedLoadWeightCellIndexPath() -> IndexPath
    func getSelectedDistanceCellIndexPath() -> IndexPath
    func didTapOnCellInBodyWeigthSection(indexPath: IndexPath)
    func didTapOnCellInMeasurementsSection(indexPath: IndexPath)
    func didTapOnCellInLoadWeigthSection(indexPath: IndexPath)
    func didTapOnCellInDistanceSection(indexPath: IndexPath)
    func didLoadView()
    func getUnitsViewModel() -> UnitsViewModel
    func didSwipe()
}

protocol UnitsInteractorInput: AnyObject {
    func updateBodyWeightMeasureUnit(measureUnit: String, section: Int?)
    func updateMeasurementsMeasureUnit(measureUnit: String, section: Int?)
    func updateLoadWeightMeasureUnit(measureUnit: String, section: Int?)
    func updateDistanceMeasureUnit(measureUnit: String, section: Int?)
}

protocol UnitsInteractorOutput: AnyObject {
    func didUpdate(measureUnit: String?, section: Int?, result: Result<Void, Error>)
}

protocol UnitsRouterInput: AnyObject {
    func getBackToMainView()
}
