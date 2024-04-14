//
//  SheetPresenter+WeightMeasurementViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import Foundation

protocol WeightMeasurementViewOutput: AnyObject {
    func didLoadWeightMeasurementView(with weight: Double?)
}

extension SheetPresenter: WeightMeasurementViewOutput {
    func didLoadWeightMeasurementView(with weight: Double? = nil) {
        let viewModel = WeightMeasurementViewModel(value: weight)
        contentView.configure(with: viewModel)
    }
}
