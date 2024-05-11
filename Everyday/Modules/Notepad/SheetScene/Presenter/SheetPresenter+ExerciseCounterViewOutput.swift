//
//  SheetPresenter+ExerciseCounterViewOutput.swift
//  Everyday
//
//  Created by Alexander on 10.05.2024.
//

import Foundation

extension SheetPresenter: ExerciseCounterViewOutput {
    func didTapSaveButton(with exercise: Exercise) {
        let counterModel = ExerciseCounterModel(exercise: exercise)
        let moduleType = SheetType.exerciseCounter(model: counterModel)
        moduleOutput?.setResult(moduleType)
        router.dismissSheet()
    }
    
    func didTapExerciseCounterCloseButton() {
        router.dismissSheet()
    }
}
