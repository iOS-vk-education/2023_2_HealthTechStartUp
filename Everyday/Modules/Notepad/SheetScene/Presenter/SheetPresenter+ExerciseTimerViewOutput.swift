//
//  SheetPresenter+ExerciseTimerViewOutput.swift
//  Everyday
//
//  Created by Alexander on 11.05.2024.
//

import Foundation

extension SheetPresenter: ExerciseTimerViewOutput {
    func didTapExerciseTimerSaveButton(with exercise: Exercise) {
        let counterModel = ExerciseCounterModel(exercise: exercise)
        let moduleType = SheetType.exerciseCounter(model: counterModel)
//        moduleOutput?.setResult(moduleType)
        router.dismissSheet()
    }
    
    func didTapExerciseTimerCloseButton() {
        router.dismissSheet()
    }
}
