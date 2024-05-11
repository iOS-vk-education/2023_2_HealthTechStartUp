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
        let exerciseCounterModel: ExerciseCounterModel = .init(exercise: exercise)
        let sheetType: SheetType = .exerciseCounter(model: exerciseCounterModel)
        let sheetConext = SheetContext(moduleOutput: self, type: sheetType)
        router.showView(with: sheetConext)
    }
    
    func didTapFinishButton() {
        let exercises = workout.sets[indexOfSet].exercises
        let resultsContext = ResultsContext(moduleOutput: self, exercises: exercises)
        router.showResults(with: resultsContext)
    }
}

extension TrainingPresenter: SheetModuleOutput {
    func setResult(_ result: SheetType) {
        switch result {
        case .exerciseCounter(let model):
            guard let index = workout.sets[indexOfSet].exercises.firstIndex(where: { $0.id == model.exercise.id }) else {
                return
            }
            
            workout.sets[indexOfSet].exercises[index].result = model.exercise.result
            switchStates[index] = true
            view?.reloadData()
        default:
            break
        }
    }
}

extension TrainingPresenter: ResultsModuleOutput {
    func changeSet(with exercises: [Exercise]) {
        indexOfSet += 1
        guard workout.sets.count > indexOfSet else {
            let extraContext = ExtraContext(workout: workout)
            router.openExtra(with: extraContext)
            return
        }
        
        switchStates = [Bool](repeating: false, count: workout.sets[indexOfSet].exercises.count)
        view?.reloadData()
    }
}

extension TrainingPresenter: TrainingInteractorOutput {
}
