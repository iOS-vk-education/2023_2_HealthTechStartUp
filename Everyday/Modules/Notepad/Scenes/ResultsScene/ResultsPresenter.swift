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
    
    private var exercises: [NewExercise]
    
    init(router: ResultsRouterInput, interactor: ResultsInteractorInput, exercises: [NewExercise]) {
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
    
    func getExercise(at index: Int) -> NewExercise {
        exercises[index]
    }
    
    func didTapCloseButton() {
        router.closeResults()
    }
    
    func didTapRestButton() {
        let timerContext = TimerContext()
        router.openTimer(with: timerContext)
    }
    
    func didTapContinueButton() {
        moduleOutput?.changeSet(with: exercises)
        router.closeResults()
    }
}

extension ResultsPresenter: ResultsInteractorOutput {
}
