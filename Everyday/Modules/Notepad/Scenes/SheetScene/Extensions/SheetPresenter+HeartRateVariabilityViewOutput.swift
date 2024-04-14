//
//  SheetPresenter+HeartRateVariabilityViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import Foundation

protocol HeartRateVariabilityViewOutput: AnyObject {
    func didLoadHeartRateVariabilityView(with heartRateVariability: HeartRateVariability?)
}

extension SheetPresenter: HeartRateVariabilityViewOutput {
    func didLoadHeartRateVariabilityView(with heartRateVariability: HeartRateVariability? = nil) {
//        let viewModel = WeightMeasurementViewModel(value: weight)
//        contentView?.configure(with: viewModel)
    }
}
