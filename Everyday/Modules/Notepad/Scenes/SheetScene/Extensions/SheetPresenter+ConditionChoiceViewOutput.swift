//
//  SheetPresenter+ConditionChoiceViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import Foundation

protocol ConditionChoiceViewOutput: AnyObject {
    func didLoadConditionChoiceView(with condition: Condition?)
    func didSelectItemAt(index: Int)
}

extension SheetPresenter: ConditionChoiceViewOutput {
    func didLoadConditionChoiceView(with condition: Condition? = nil) {
//        let viewModel = WeightMeasurementViewModel(value: weight)
//        contentView?.configure(with: viewModel)
    }
    
    func didSelectItemAt(index: Int) {
        let condition = Condition.allCases[index]
        let conditionChoiceModel: ConditionChoiceModel = .init(
            condition: condition,
            status: "New condition set"
        )
        moduleType = .conditionChoice(model: conditionChoiceModel)
    }
}
