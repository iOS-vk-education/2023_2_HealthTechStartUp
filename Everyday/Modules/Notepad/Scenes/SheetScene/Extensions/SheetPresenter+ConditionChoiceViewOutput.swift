//
//  SheetPresenter+ConditionChoiceViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import Foundation

protocol ConditionChoiceViewOutput: AnyObject {
    func didLoadConditionChoiceView(with condition: Condition?)
}

extension SheetPresenter: ConditionChoiceViewOutput {
    func didLoadConditionChoiceView(with condition: Condition? = nil) {
//        let viewModel = WeightMeasurementViewModel(value: weight)
//        contentView?.configure(with: viewModel)
    }
}
