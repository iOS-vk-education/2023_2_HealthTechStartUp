//
//  ExercisePresenter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//
//

import Foundation

final class ExercisePresenter {
    weak var view: ExerciseViewInput?
    weak var moduleOutput: ExerciseModuleOutput?
    
    private let router: ExerciseRouterInput
    private let interactor: ExerciseInteractorInput
    
    private var exercise: Exercise
    private var indexOfSet: Int
    private var result: Int = 0
    
    init(router: ExerciseRouterInput, interactor: ExerciseInteractorInput, exercise: Exercise, indexOfSet: Int) {
        self.router = router
        self.interactor = interactor
        self.exercise = exercise
        self.indexOfSet = indexOfSet
    }
}

extension ExercisePresenter: ExerciseModuleInput {
}

extension ExercisePresenter: ExerciseViewOutput {
    func didLoadView() {
        let viewModel = ExerciseViewModel(exercise: exercise)
        view?.configure(with: viewModel)
    }
    
    func didTapSaveButton() {
        moduleOutput?.setResult(of: exercise.name, with: String(result), at: indexOfSet)
        router.closeExercise()
    }
    
    func didTapCloseButton() {
        router.closeExercise()
    }
    
    func didTapMinusButton() {
        guard
            result > 0
        else {
            return
        }
        
        result -= 1
        view?.updateResult(with: String(result))
    }
    
    func didTapPlusButton() {
        result += 1
        view?.updateResult(with: String(result))
    }
}

extension ExercisePresenter: ExerciseInteractorOutput {
}
