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
    
    private var workoutDay: WorkoutDay
    private var indexOfSet: Int = 0
    private var switchStates: [Bool] = []
    
    init(router: TrainingRouterInput, interactor: TrainingInteractorInput, workoutDay: WorkoutDay) {
        self.router = router
        self.interactor = interactor
        self.workoutDay = workoutDay
    }
}

extension TrainingPresenter: TrainingModuleInput {
}

extension TrainingPresenter: TrainingViewOutput {
    func didLoadView() {
        let viewModel = TrainingViewModel()
        view?.configure(with: viewModel)
        switchStates = [Bool](repeating: false, count: workoutDay.workout.days[workoutDay.indexOfDay].sets[0].exercises.count)
        view?.reloadData()
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        workoutDay.workout.days[workoutDay.indexOfDay].sets[indexOfSet].exercises.count
    }
    
    func getExercise(at index: Int) -> Exercise {
        workoutDay.workout.days[workoutDay.indexOfDay].sets[indexOfSet].exercises[index]
    }
    
    func setSwitchState(at index: Int, with value: Bool) {
        switchStates[index] = value
        let allSatisfy = switchStates.allSatisfy { $0 }
        if allSatisfy {
//            view?.showFinishButton()
        } else {
//            view?.hideFinishButton()
        }
    }
    
    func getSwitchState(at index: Int) -> Bool {
        switchStates[index]
    }
    
    func didSelectRowAt(index: Int) {
        if !switchStates[index] {
            let exercise = workoutDay.workout.days[workoutDay.indexOfDay].sets[indexOfSet].exercises[index]
            let exerciseContext = ExerciseContext(moduleOutput: self, exercise: exercise, indexOfSet: indexOfSet)
            router.openExercise(with: exerciseContext)
        }
    }
    
    func didTapStartButton(number: Int) {
        let exercise = workoutDay.workout.days[workoutDay.indexOfDay].sets[indexOfSet].exercises[number]
        let exerciseContext = ExerciseContext(moduleOutput: self, exercise: exercise, indexOfSet: indexOfSet)
        router.openExercise(with: exerciseContext)
    }
    
    func didTapFinishButton() {
        let exercises = workoutDay.workout.days[workoutDay.indexOfDay].sets[indexOfSet].exercises
        let resultsContext = ResultsContext(moduleOutput: self, exercises: exercises)
        router.showResults(with: resultsContext)
    }
}

extension TrainingPresenter: ExerciseModuleOutput {
    func setResult(of exercise: String, with result: String, at indexOfSet: Int) {
        let exercises = self.workoutDay.workout.days[workoutDay.indexOfDay].sets[indexOfSet].exercises
        guard let indexOfExercise = exercises.firstIndex(where: { $0.name == exercise }) else {
            return
        }
        
        self.workoutDay.workout.days[workoutDay.indexOfDay].sets[indexOfSet].exercises[indexOfExercise].result = result
        view?.reloadData()
    }
}

extension TrainingPresenter: ResultsModuleOutput {
    func changeSet(with exercises: [Exercise]) {
        let index = workoutDay.workout.days[workoutDay.indexOfDay].sets.firstIndex { $0.exercises[0].name == exercises[0].name }!
        if workoutDay.workout.days[workoutDay.indexOfDay].sets.count > index + 1 {
            self.indexOfSet = index + 1
        } else {
            router.openNotepad()
            return
        }
        
        switchStates = [Bool](repeating: false, count: workoutDay.workout.days[workoutDay.indexOfDay].sets[indexOfSet].exercises.count)
//        view?.hideFinishButton()
        view?.reloadData()
    }
}

extension TrainingPresenter: TrainingInteractorOutput {
}
