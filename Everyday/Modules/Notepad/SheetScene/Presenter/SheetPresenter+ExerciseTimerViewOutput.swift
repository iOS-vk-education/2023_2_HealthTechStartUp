//
//  SheetPresenter+ExerciseTimerViewOutput.swift
//  Everyday
//
//  Created by Alexander on 11.05.2024.
//

import Foundation

extension SheetPresenter: ExerciseTimerViewOutput {
    func didTapExerciseTimerSaveButton(with exercise: Exercise) {
        let counterModel: ExerciseTimerModel = .init(exercise: exercise)
        let moduleType: SheetType = .exerciseTimer(model: counterModel)
        moduleOutput?.setResult(moduleType)
        router.dismissSheet()
    }
    
    func didTapExerciseTimerCloseButton() {
        router.dismissSheet()
    }
}
