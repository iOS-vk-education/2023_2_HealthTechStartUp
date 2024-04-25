//
//  SheetPresenter+ConditionChoiceViewOutput.swift
//  Everyday
//
//  Created by Alexander on 14.04.2024.
//

import Foundation

extension SheetPresenter: ConditionChoiceViewOutput {
    func didTapSaveButton(with condition: Condition?) {
        print("[DEBUG] choice save button")
        let conditionChoiceModel = ConditionChoiceModel(condition: condition)
        let moduleType = SheetType.conditionChoice(model: conditionChoiceModel)
        moduleOutput?.setResult(moduleType, at: 1)
        router.dismissSheet()
    }
    
    func didTapConditionChoiceCloseButton() {
        router.dismissSheet()
    }
}
