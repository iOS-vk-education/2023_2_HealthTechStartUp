//
//  SheetPresenter+TimerViewOutput.swift
//  Everyday
//
//  Created by Alexander on 11.05.2024.
//

import Foundation

extension SheetPresenter: TimerViewOutput {
    func didTapTimerSaveButton() {
//        let counterModel = ExerciseCounterModel(exercise: exercise)
//        let moduleType = SheetType.exerciseCounter(model: counterModel)
//        moduleOutput?.setResult(moduleType)
        router.dismissSheet()
    }
    
    func didTapTimerCloseButton() {
        router.dismissSheet()
    }
}
