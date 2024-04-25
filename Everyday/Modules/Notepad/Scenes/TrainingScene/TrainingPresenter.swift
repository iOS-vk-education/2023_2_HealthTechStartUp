//
//  TrainingPresenter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//
//

import Foundation

final class TrainingPresenter {
    weak var view: TrainingViewInput?
    weak var moduleOutput: TrainingModuleOutput?
    
    private let router: TrainingRouterInput
    private let interactor: TrainingInteractorInput
    
    private var workout: Workout
    private var indexOfSet: Int = 0
    private var switchStates: [Bool] = []
    
    init(router: TrainingRouterInput, interactor: TrainingInteractorInput, workout: Workout) {
        self.router = router
        self.interactor = interactor
        self.workout = workout
    }
}

extension TrainingPresenter: TrainingModuleInput {
}

extension TrainingPresenter: TrainingViewOutput {
    func didLoadView() {
        let viewModel = TrainingViewModel()
        view?.configure(with: viewModel)
        switchStates = [Bool](repeating: false, count: workout.sets[indexOfSet].exercises.count)
        view?.reloadData()
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        workout.sets[indexOfSet].exercises.count
    }
    
    func getExercise(at index: Int) -> Exercise {
        workout.sets[indexOfSet].exercises[index]
    }
    
    func getSwitchState(at index: Int) -> Bool {
        switchStates[index]
    }
    
    func didSelectRowAt(index: Int) {
        let exercise = workout.sets[indexOfSet].exercises[index]
        let exerciseContext = ExerciseContext(moduleOutput: self, exercise: exercise, indexOfSet: indexOfSet)
        router.openExercise(with: exerciseContext)
    }
    
    func didTapFinishButton() {
        let exercises = workout.sets[indexOfSet].exercises
        let resultsContext = ResultsContext(moduleOutput: self, exercises: exercises)
        router.showResults(with: resultsContext)
    }
}

extension TrainingPresenter: ExerciseModuleOutput {
    func setResult(of exercise: String, with result: String, at indexOfSet: Int) {
        let exercises = workout.sets[indexOfSet].exercises
        guard let indexOfExercise = exercises.firstIndex(where: { $0.name == exercise }) else {
            return
        }
        
        workout.sets[indexOfSet].exercises[indexOfExercise].result = result
        switchStates[indexOfExercise] = true
        view?.reloadData()
    }
}

extension TrainingPresenter: ResultsModuleOutput {
    func changeSet(with exercises: [Exercise]) {
        let index = workout.sets.firstIndex { $0.exercises[0].name == exercises[0].name }!
        if workout.sets.count > index + 1 {
            indexOfSet = index + 1
        } else {
            router.openExtra()
            return
        }
        
        switchStates = [Bool](repeating: false, count: workout.sets[indexOfSet].exercises.count)
        view?.reloadData()
    }
}

extension TrainingPresenter: TrainingInteractorOutput {
}
