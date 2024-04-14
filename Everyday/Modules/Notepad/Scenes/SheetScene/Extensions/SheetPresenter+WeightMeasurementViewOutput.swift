//
//  SheetPresenter+WeightMeasurementViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import Foundation

protocol WeightMeasurementViewOutput: AnyObject {
    func didLoadWeightMeasurementView()
}

extension SheetPresenter: WeightMeasurementViewOutput {
    func didLoadWeightMeasurementView() {
        var weight: Double?
        switch moduleType {
        case .weightMeasurement(let weightMeasurementModel):
            weight = weightMeasurementModel.weight
        default:
            break
        }
        let viewModel = WeightMeasurementViewModel(value: weight)
        weightMeasurementView?.configure(with: viewModel)
    }
}
