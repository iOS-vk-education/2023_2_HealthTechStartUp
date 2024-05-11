//
//  ResultsPresenter.swift
//  Everyday
//
//  Created by user on 28.02.2024.
//  
//

import Foundation

final class ResultsPresenter {
    weak var view: ResultsViewInput?
    weak var moduleOutput: ResultsModuleOutput?
    
    private let router: ResultsRouterInput
    private let interactor: ResultsInteractorInput
    
    private var exercises: [Exercise]
    
    init(router: ResultsRouterInput, interactor: ResultsInteractorInput, exercises: [Exercise]) {
        self.router = router
        self.interactor = interactor
        self.exercises = exercises
    }
}

extension ResultsPresenter: ResultsModuleInput {
}

extension ResultsPresenter: ResultsViewOutput {
    func didLoadView() {
        let viewModel = ResultsViewModel()
        view?.configure(with: viewModel)
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        exercises.count
    }
    
    func getExercise(at index: Int) -> Exercise {
        exercises[index]
    }
    
    func didTapCloseButton() {
        router.closeResults()
    }
    
    func didTapRestButton() {
//        let timerContext = TimerContext()
//        router.openTimer(with: timerContext)
        
        let exercise = exercises[0]
        let exerciseTimerModel: ExerciseTimerModel = .init(exercise: exercise)
        let sheetType: SheetType = .exerciseTimer(model: exerciseTimerModel)
        let sheetConext = SheetContext(moduleOutput: self, type: sheetType)
        router.showView(with: sheetConext)
    }
    
    func didTapContinueButton() {
        moduleOutput?.changeSet(with: exercises)
        router.closeResults()
    }
}

extension ResultsPresenter: SheetModuleOutput {
    func setResult(_ result: SheetType) {
        var index = -1
        switch result {
        case .exerciseCounter(let model):
            index = exercises.firstIndex(where: { $0.name == model.exercise.name }) ?? -1
            
            guard index < exercises.count, index >= 0 else {
                return
            }
            
            exercises[index].result = model.exercise.result
        default:
            break
        }
        guard index < exercises.count, index >= 0 else {
            return
        }
        
        view?.reloadData()
    }
}

extension ResultsPresenter: ResultsInteractorOutput {
}
